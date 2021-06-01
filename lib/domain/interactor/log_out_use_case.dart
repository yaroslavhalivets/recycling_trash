import 'package:retrash_app/domain/repository/auth_repository.dart';
import 'package:retrash_app/main.dart';

class LogOutUseCase {
  Future<void> execute() => sl.get<AuthRepository>().logOut();
}
