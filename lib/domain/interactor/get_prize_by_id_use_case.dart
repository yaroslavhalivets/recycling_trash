import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/domain/repository/prizes_repository.dart';
import 'package:retrash_app/main.dart';

class GetPrizesByIdUseCase {
  Future<PrizeApi?> execute(int id) =>
      sl.get<PrizesRepository>().getPrizesById(id);
}
