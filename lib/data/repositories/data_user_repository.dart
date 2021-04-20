import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class DataUserRepository implements UserRepository {
  Db _db;

  DataUserRepository() : _db = sl.get<Db>();

  Future<UserCredential?> logIn(String email, String password) {
    return _db.logIn(email, password);
  }
}
