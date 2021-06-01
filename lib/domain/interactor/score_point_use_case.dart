import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class ScorePointUseCase {
  Future<void> execute(int points) =>
      sl.get<UserRepository>().scorePoint(points);
}
