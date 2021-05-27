import 'package:retrash_app/domain/interactor/check_auth_use_case.dart';
import 'package:retrash_app/domain/interactor/sign_in_use_case.dart';
import 'package:retrash_app/domain/interactor/sign_up_use_case.dart';
import 'package:retrash_app/main.dart';

import 'module.dart';

class AuthModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
    sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase());
    sl.registerLazySingleton<CheckAuthUseCase>(() => CheckAuthUseCase());
  }
}
