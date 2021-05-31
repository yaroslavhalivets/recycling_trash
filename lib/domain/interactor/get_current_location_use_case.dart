import 'package:retrash_app/data/api/location_api.dart';
import 'package:retrash_app/data/location_manager/location_manager.dart';
import 'package:retrash_app/main.dart';

class GetCurrentLocationUseCase {
  Future<LocationApi?> execute() => sl.get<LocationManager>().getLocation();
}
