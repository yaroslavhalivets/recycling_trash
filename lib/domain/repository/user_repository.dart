import 'package:firebase_auth/firebase_auth.dart';

abstract class UserRepository {
  Future<UserCredential?> logIn(String email, String password);
}
