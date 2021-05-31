import 'package:retrash_app/domain/interactor/get_trash_cans_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/di/modules/module.dart';

class TrashCanModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<GetTrashCanUseCase>(() => GetTrashCanUseCase());
  }
}
