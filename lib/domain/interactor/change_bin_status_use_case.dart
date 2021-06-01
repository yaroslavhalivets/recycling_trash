import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_statuses.dart';
import 'package:retrash_app/domain/repository/trash_can_repository.dart';
import 'package:retrash_app/main.dart';

class ChangeBinStatusUseCase {
  Future<void> execute(TrashCanApi canApi, TrashCanStatuses status) =>
      sl.get<TrashCanRepository>().changeBinStatus(canApi, status);
}
