import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/data/requests/auth_request.dart';

abstract class UserRepository {
  Future<void> createUser(AuthRequest request, Uid uid);
  Future<UserApi?> getUser();
  Future<String?> getProfilePhoto();
}
