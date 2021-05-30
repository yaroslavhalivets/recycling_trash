import 'package:retrash_app/data/cache/cache_manager.dart';
import 'package:retrash_app/data/cache/data_cache_manager.dart';
import 'package:retrash_app/data/repositories/data_auth_repository.dart';
import 'package:retrash_app/data/repositories/data_prizes_repository.dart';
import 'package:retrash_app/data/repositories/data_user_repository.dart';
import 'package:retrash_app/domain/repository/prizes_repository.dart';
import 'package:retrash_app/presentation/di/modules/module.dart';
import 'package:retrash_app/domain/repository/auth_repository.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class RepositoryModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<UserRepository>(() => DataUserRepository());
    sl.registerLazySingleton<CacheManager>(() => DataCacheManager());
    sl.registerLazySingleton<AuthRepository>(() => DataAuthRepository());
    sl.registerLazySingleton<PrizesRepository>(() => DataPrizesRepository());
  }
}
