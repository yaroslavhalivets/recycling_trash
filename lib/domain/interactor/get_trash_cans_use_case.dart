import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/domain/repository/trash_can_repository.dart';
import 'package:retrash_app/main.dart';

class GetTrashCanUseCase {
  Future<List<TrashCanApi>> execute() => sl.get<TrashCanRepository>().getTrashCans();
}
