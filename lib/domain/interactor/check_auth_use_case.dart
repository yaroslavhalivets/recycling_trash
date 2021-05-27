import 'package:retrash_app/domain/repository/auth_repository.dart';
import 'package:retrash_app/main.dart';

class CheckAuthUseCase {
  final AuthRepository _repository = sl.get<AuthRepository>();

  Future<bool> execute() => _repository.checkAuth();
}
