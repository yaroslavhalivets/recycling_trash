import 'package:retrash_app/data/repositories/data_user_repository.dart';
import 'package:retrash_app/di/modules/module.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class RepositoryModule implements Module {
  @override
  void dependency() {
    sl.registerLazySingleton<UserRepository>(() => DataUserRepository());
  }
}
