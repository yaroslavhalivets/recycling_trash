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
    await _db.setData('Users', docName: uid.uid, data: userApi.toMap());
  }

  @override
  Future<UserApi?> getUser() async {
    Uid? uid = await _cacheManager.getUid();
    if (uid != null && uid.uid != null) {
      var data = await _db.getDocument('Users', uid.uid);
      if (data != null) {
        return UserApi.fromJson(data);
      }
      return null;
    }
    return null;
  }

  Future<String?> getProfilePhoto() async {
    UserApi? userApi = await getUser();
    if (userApi != null) {
      return userApi.photoUrl;
    }
    return null;
  }

  Future<void> setUserPrize(int prizeId) async {
    var data = {'prize_id': prizeId};

    Uid? uid = await _cacheManager.getUid();
    if (uid != null && uid.uid != null) {
      await _db.setData('Users', docName: uid.uid, data: data);
    }
  }
}
