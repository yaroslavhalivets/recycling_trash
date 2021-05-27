import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/repository/auth_repository.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';

import '../../main.dart';

class SignUpUseCase {
  final UserRepository _userRepository = sl.get<UserRepository>();
  final AuthRepository _authRepository = sl.get<AuthRepository>();

  Future<void> createUser(AuthRequest request, Uid uid) =>
      _userRepository.createUser(request, uid);

  Future<UserCredential> signUp(AuthRequest request) =>
      _authRepository.signUp(request);
}
