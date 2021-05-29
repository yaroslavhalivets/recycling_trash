import 'package:retrash_app/domain/interactor/set_user_pize_use_case.dart';
import 'package:retrash_app/presentation/di/modules/module.dart';
import 'package:retrash_app/domain/interactor/get_user_photo_use_case.dart';

import '../../../main.dart';

class UserModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<GetUserPhotoUseCase>(() => GetUserPhotoUseCase());
    sl.registerLazySingleton<SetUserPriseUseCase>(() => SetUserPriseUseCase());
  }
}
