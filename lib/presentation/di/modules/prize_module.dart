import 'package:retrash_app/domain/interactor/get_prizes_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/di/modules/module.dart';

class PrizeModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<GetPrizesUseCase>(() => GetPrizesUseCase());
  }
}
