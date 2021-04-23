import 'package:retrash_app/data/api/location_api.dart';

abstract class LocationManager {
  Future<LocationApi?> getLocation();
}
