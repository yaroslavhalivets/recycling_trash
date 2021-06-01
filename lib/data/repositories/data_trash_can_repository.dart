import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_statuses.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/domain/repository/trash_can_repository.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/data/type_alias.dart';

class DataTrashCanRepository implements TrashCanRepository {
  Db _db;

  DataTrashCanRepository() : _db = sl.get<Db>();

  Future<List<TrashCanApi>> getTrashCans() async {
    List<Json>? data = await _db.get('TrashCan');
    List<TrashCanApi> cans = <TrashCanApi>[];
    for (Json json in data!) {
      cans.add(TrashCanApi.fromJson(json));
    }
    return cans;
  }

  Future<void> changeBinStatus(
      TrashCanApi canApi, TrashCanStatuses status) async {
    Json data = {
      'geopoint': canApi.geoPoint,
      'id': canApi.id,
      'status': status.name,
    };

    await _db.setData('TrashCan', docName: canApi.id, data: data);
  }
}
