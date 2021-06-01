import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_statuses.dart';

abstract class TrashCanRepository {
  Future<List<TrashCanApi>> getTrashCans();
  Future<void> changeBinStatus(TrashCanApi canApi, TrashCanStatuses status);
}
