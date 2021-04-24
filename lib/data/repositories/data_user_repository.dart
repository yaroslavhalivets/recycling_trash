import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/data/cache/cache_manager.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class DataUserRepository implements UserRepository {
  final Db _db;
  final CacheManager _cacheManager;

  DataUserRepository()
      : _db = sl.get<Db>(),
        _cacheManager = sl.get<CacheManager>();

  @override
  Future<void> createUser(AuthRequest request, Uid uid) async {
    String? photoUrl;
    if (request.profilePhoto != null) {
      photoUrl = await _db.uploadSingleFile('users_photos',
          fileData: request.profilePhoto!);
    }

    UserApi userApi = UserApi.init(request.name, request.surname,
        request.phoneNumber, request.email, photoUrl);

    await _cacheManager.saveUid(uid);
    await _db.add('Users', data: userApi.toMap());
  }
}
