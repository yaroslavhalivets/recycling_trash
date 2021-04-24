import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/requests/auth_request.dart';

abstract class UserRepository {
  Future<UserCredential> logIn(String email, String password);
  Future<UserCredential> signUp(AuthRequest request);
  Future<void> createUser(AuthRequest request);
}
