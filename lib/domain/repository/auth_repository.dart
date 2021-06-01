import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/requests/auth_request.dart';

abstract class AuthRepository {
  Future<UserCredential> logIn(String email, String password);
  Future<UserCredential> signUp(AuthRequest request);
  Future<bool> saveUid(Uid uid);
  Future<bool> checkAuth();
  Future<void> logOut();
}
