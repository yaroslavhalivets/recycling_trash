import 'package:retrash_app/data/api/location_api.dart';
import 'package:retrash_app/data/api/trash_can_api/trash_can_api.dart';
import 'package:retrash_app/domain/interactor/get_current_location_use_case.dart';
import 'package:retrash_app/domain/interactor/get_trash_cans_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';
import 'package:rxdart/rxdart.dart';

class MapBloc extends BaseBloc {
  final BehaviorSubject<List<TrashCanApi>> trashCans =
      BehaviorSubject<List<TrashCanApi>>();

  @override
  void init() {
    getTrashCans();
  }

  @override
  void dispose() {
    trashCans.close();
    super.dispose();
  }

  Future<void> getTrashCans() async {
    final List<TrashCanApi> cans = await sl.get<GetTrashCanUseCase>().execute();
    if (cans.isNotEmpty && !trashCans.isClosed) {
      trashCans.sink.add(cans);
    }
  }

  Future<LocationApi?> getCurrentLocation() =>
      sl.get<GetCurrentLocationUseCase>().execute();
}
