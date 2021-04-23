import 'package:retrash_app/domain/injectors/user_use_case.dart';
import 'package:retrash_app/main.dart';

import 'module.dart';

class InjectorsModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<UserUseCase>(() => UserUseCase());
  }
}
