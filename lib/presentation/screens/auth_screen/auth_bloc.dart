import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/domain/interactor/sign_in_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class AuthBloc extends BaseBloc {
  final SignInUseCase _authUseCase = sl.get<SignInUseCase>();

  Future<UserCredential> logIn(String email, String password) {
    return _authUseCase.logIn(email, password).catchError((e) {
      dispatchError(e);
    });
  }

  Future<void> saveUid(UserCredential credential) async {
    String? uid = credential.user?.uid;
    await _authUseCase.saveUid(Uid(uid));
  }
}
