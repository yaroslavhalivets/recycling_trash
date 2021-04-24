import 'dart:convert';

import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/cache/cache_manager.dart';
import 'package:retrash_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DataCacheManager implements CacheManager {
  static const String _kUserToken = 'USER_TOKEN';

  late final Future<SharedPreferences> shrp;

  DataCacheManager() : shrp = SharedPreferences.getInstance();

  @override
  Future<bool> saveUid(Uid uid) async {
    SharedPreferences sp = await shrp;
    return sp.setString(_kUserToken, json.encode(uid.toMap()));
  }

  @override
  Future<Uid?> getUid() async {
    SharedPreferences sp = await shrp;
    if (sp.containsKey(_kUserToken)) {
      try {
        return Uid.fromJson(json.decode(sp.getString(_kUserToken)!));
      } catch (e) {
        logger.e(e);
        return null;
      }
    } else {
      return null;
    }
  }

  @override
  Future<bool> clear() async {
    SharedPreferences sp = await shrp;
    return sp.clear();
  }
}
