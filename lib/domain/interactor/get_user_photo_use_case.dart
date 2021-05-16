import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class GetUserPhotoUseCase {
  final UserRepository _repository = sl.get<UserRepository>();

  Future<String?> execute() => _repository.getProfilePhoto();
}
