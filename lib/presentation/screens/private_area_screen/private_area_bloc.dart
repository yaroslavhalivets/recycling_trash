import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/domain/interactor/get_prize_by_id_use_case.dart';
import 'package:retrash_app/domain/interactor/get_user_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class PrivateAreaBloc extends BaseBloc {
  Future<UserApi?> getUser() => sl.get<GetUserUseCase>().execute();

  Future<PrizeApi?> getPrize() async {
    UserApi? userApi = await sl.get<GetUserUseCase>().execute();
    if (userApi != null && userApi.prizeId != null) {
      PrizeApi? prizeApi =
          await sl.get<GetPrizesByIdUseCase>().execute(userApi.prizeId!);
      return prizeApi;
    }
    return null;
  }

  Future<double?> getAwardPercentStatus() async {
    UserApi? userApi = await sl.get<GetUserUseCase>().execute();
    if (userApi != null && userApi.prizeId != null) {
      PrizeApi? prizeApi =
          await sl.get<GetPrizesByIdUseCase>().execute(userApi.prizeId!);
      if (prizeApi != null) {
        return (userApi.points ?? 0 * 100) / prizeApi.requiredPoints;
      }
    }
    return null;
  }
}
