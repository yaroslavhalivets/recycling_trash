import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class GetUserUseCase {
  Future<UserApi?> execute() => sl.get<UserRepository>().getUser();
}
