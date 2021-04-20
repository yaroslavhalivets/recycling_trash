import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/domain/injectors/user_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class AuthBloc extends BaseBloc {
  final UserUseCase _userUseCase = sl.get<UserUseCase>();

  Future<UserCredential?> logIn(String email, String password) {
    return _userUseCase.logIn(email, password);
  }
}
