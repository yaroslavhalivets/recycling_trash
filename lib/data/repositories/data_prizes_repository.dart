import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/data/api/prize_api/prize_type.dart';
import 'package:retrash_app/data/db/db.dart';
import 'package:retrash_app/domain/repository/prizes_repository.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/data/type_alias.dart';

class DataPrizesRepository implements PrizesRepository {
  final Db _db;

  DataPrizesRepository() : _db = sl.get<Db>();

  @override
  Future<List<PrizeApi>> getPrizes() async {
    List<Json>? data = await _db.get('Prizes');
    List<PrizeApi> prizes = <PrizeApi>[];
    for (Json json in data!) {
      prizes.add(PrizeApi.fromJson(json));
    }
    return prizes;
  }

  @override
  Future<List<PrizeApi>> getPrizesByType(PrizeType type) async {
    List<Json>? data = await _db.get('Prizes');
    List<PrizeApi> prizes = <PrizeApi>[];
    for (Json json in data!) {
      PrizeApi prize = PrizeApi.fromJson(json);
      if (prize.prizeType == type) {
        prizes.add(PrizeApi.fromJson(json));
      }
    }
    return prizes;
  }

  @override
  Future<PrizeApi?> getPrizesById(int id) async {
    List<Json>? data = await _db.get('Prizes');
    for (Json json in data!) {
      PrizeApi prize = PrizeApi.fromJson(json);
      if (prize.id == id) {
        return PrizeApi.fromJson(json);
      }
    }
    return null;
  }
}
