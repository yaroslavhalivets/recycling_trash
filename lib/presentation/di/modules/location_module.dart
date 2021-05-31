import 'package:retrash_app/data/location_manager/data_location_manager.dart';
import 'package:retrash_app/data/location_manager/location_manager.dart';
import 'package:retrash_app/domain/interactor/get_current_location_use_case.dart';
import 'package:retrash_app/presentation/di/modules/module.dart';
import 'package:retrash_app/main.dart';

class LocationModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<LocationManager>(() => DataLocationManager());
    sl.registerLazySingleton<GetCurrentLocationUseCase>(
        () => GetCurrentLocationUseCase());
  }
}
