import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/requests/auth_request.dart';

abstract class UserRepository {
  Future<void> createUser(AuthRequest request, Uid uid);
}
