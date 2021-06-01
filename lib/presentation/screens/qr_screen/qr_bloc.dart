import 'package:retrash_app/domain/interactor/score_point_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class QrBloc extends BaseBloc {
  Future<void> scorePoint(int points) =>
      sl.get<ScorePointUseCase>().execute(points);
}
