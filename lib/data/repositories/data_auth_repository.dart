import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/cache/cache_manager.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/repository/auth_repository.dart';

import '../../main.dart';

class DataAuthRepository implements AuthRepository {
  final Db _db;
  final CacheManager _cacheManager;

  DataAuthRepository()
      : _db = sl.get<Db>(),
        _cacheManager = sl.get<CacheManager>();

  @override
  Future<UserCredential> logIn(String email, String password) {
    return _db.signIn(email, password);
  }

  @override
  Future<bool> saveUid(Uid uid) {
    return _cacheManager.saveUid(uid);
  }

  @override
  Future<UserCredential> signUp(AuthRequest request) async {
    return _db.signUp(request.email, request.password);
  }

  @override
  Future<bool> checkAuth() async {
    Uid? uid = await _cacheManager.getUid();
    return uid != null && uid.uid != null;
  }
}
