import 'package:retrash_app/data/api/uid.dart';

abstract class CacheManager {
  Future<bool> clear();
  Future<bool> saveUid(Uid uid);
  Future<Uid?> getUid();
}
