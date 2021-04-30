import 'package:retrash_app/domain/injectors/check_auth_use_case.dart';
import 'package:retrash_app/domain/injectors/get_user_photo_use_case.dart';
import 'package:retrash_app/domain/injectors/sign_in_use_case.dart';
import 'package:retrash_app/domain/injectors/sign_up_use_case.dart';
import 'package:retrash_app/main.dart';

import 'module.dart';

class InjectorsModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<SignUpUseCase>(() => SignUpUseCase());
    sl.registerLazySingleton<SignInUseCase>(() => SignInUseCase());
    sl.registerLazySingleton<CheckAuthUseCase>(() => CheckAuthUseCase());
    sl.registerLazySingleton<GetUserPhotoUseCase>(() => GetUserPhotoUseCase());
  }
}
