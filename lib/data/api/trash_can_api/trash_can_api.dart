import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_statuses.dart';
import 'package:retrash_app/data/type_alias.dart';
import 'package:retrash_app/utils/encode_map.dart';

class TrashCanApi {
  int id;
  GeoPoint geoPoint;
  TrashCanStatuses status;

  TrashCanApi(this.id, this.geoPoint, this.status);

  factory TrashCanApi.fromJson(Json json) => TrashCanApi(
      json['id'], json['geopoint'], encodeMap(json['status'], _statusMap)!);
}

const _statusMap = {'work': TrashCanStatuses.work};
