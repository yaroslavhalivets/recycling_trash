import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';

class SetFavoriteBinUseCase {
  Future<void> execute(TrashCanApi api, {bool disActivate = false}) =>
      sl.get<UserRepository>().setFavoriteBin(api, disActivate: disActivate);
}
