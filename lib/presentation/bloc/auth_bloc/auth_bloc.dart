import 'dart:async';

import 'package:retrash_app/domain/injectors/user_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class AuthBloc extends BaseBloc {
  final UserUseCase _userUseCase = sl.get<UserUseCase>();

  Future<void> logIn(String email, String password) async {
    await _userUseCase.logIn(email, password).catchError((e) {
      dispatchError(e);
    });
  }
}
