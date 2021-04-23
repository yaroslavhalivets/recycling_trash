import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class UserUseCase {
  UserRepository _repository = sl.get<UserRepository>();

  Future<UserCredential> logIn(String email, String password) =>
      _repository.logIn(email, password);

  Future<UserCredential> signUp(AuthRequest request) =>
      _repository.signUp(request);
}
