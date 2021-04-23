import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class DataUserRepository implements UserRepository {
  Db _db;

  DataUserRepository() : _db = sl.get<Db>();

  Future<UserCredential?> logIn(String email, String password) {
    return _db.signIn(email, password);
  }

  Future<UserCredential?> signUp(AuthRequest request) async {
    return _db.signUp(request.email, request.password);
  }
}
