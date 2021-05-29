import 'package:retrash_app/data/api/prize_api/prize_api.dart';
import 'package:retrash_app/data/api/user_api.dart';
import 'package:retrash_app/domain/interactor/get_prizes_use_case.dart';
import 'package:retrash_app/domain/repository/user_repository.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class PresentsBloc extends BaseBloc {
  Future<List<PrizeApi>> getPrizes() => sl.get<GetPrizesUseCase>().execute();
  Future<UserApi?> getUser() => sl.get<UserRepository>().getUser();
}
