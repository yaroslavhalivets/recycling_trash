import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class SetUserPriseUseCase {
  Future<void> execute(int id) => sl.get<UserRepository>().setUserPrize(id);
}
