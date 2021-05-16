import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/domain/repository/auth_repository.dart';
import 'package:retrash_app/main.dart';

class SignInUseCase {
  final AuthRepository _repository = sl.get<AuthRepository>();
  
  Future<UserCredential> logIn(String email, String password) =>
      _repository.logIn(email, password);
  Future<bool> saveUid(Uid uid) =>
      _repository.saveUid(uid);
}
