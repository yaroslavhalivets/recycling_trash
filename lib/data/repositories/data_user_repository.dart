import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class DataUserRepository implements UserRepository {
  Db _db;

  DataUserRepository() : _db = sl.get<Db>();

  @override
  Future<UserCredential> logIn(String email, String password) async {
    return _db.signIn(email, password);
  }

  @override
  Future<UserCredential> signUp(AuthRequest request) async {
    return _db.signUp(request.email, request.password);
  }

  @override
  Future<void> createUser(AuthRequest request) async {
    String? photoUrl;
    if (request.profilePhoto != null) {
      photoUrl = await _db.uploadSingleFile('users_photos',
          fileData: request.profilePhoto!);
    }

    UserApi userApi = UserApi.init(request.name, request.surname,
        request.phoneNumber, request.email, photoUrl);

    await _db.add('Users', data: userApi.toMap());
  }
}
