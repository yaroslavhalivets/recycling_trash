import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';

abstract class TrashCanRepository {
  Future<List<TrashCanApi>> getTrashCans();
}
