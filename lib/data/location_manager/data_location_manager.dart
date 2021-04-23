import 'package:location/location.dart';
import 'package:retrash_app/data/api/location_api.dart';
import 'package:retrash_app/data/location_manager/location_manager.dart';
import 'package:retrash_app/utils/encode_map.dart';

class DataLocationManager implements LocationManager {
  final Location _location = Location();

  @override
  Future<LocationApi?> getLocation() async {
    bool? permission = await _getPermissions();
    if (permission != null && permission) {
      LocationData data = await _location.getLocation();
      return LocationApi(latitude: data.latitude, longitude: data.longitude);
    }
    return null;
  }

  Future<bool?> _getPermissions() async {
    var permission = await _location.requestPermission();
    return encodeMap(permission, _permissionsResult);
  }
}

const _permissionsResult = {
  PermissionStatus.denied: false,
  PermissionStatus.deniedForever: false,
  PermissionStatus.granted: true,
  PermissionStatus.grantedLimited: true
};
