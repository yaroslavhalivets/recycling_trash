import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/data/api/prize_api/prize_type.dart';

abstract class PrizesRepository {
  Future<List<PrizeApi>> getPrizes();
  Future<List<PrizeApi>> getPrizesByType(PrizeType type);
  Future<PrizeApi?> getPrizesById(int id);
}
