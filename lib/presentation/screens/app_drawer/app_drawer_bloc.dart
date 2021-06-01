import 'package:retrash_app/domain/interactor/get_user_photo_use_case.dart';
import 'package:retrash_app/domain/interactor/log_out_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class AppDrawerBloc extends BaseBloc {
  final GetUserPhotoUseCase _photoUseCase = sl.get<GetUserPhotoUseCase>();

  Future<String?> getProfilePhoto() => _photoUseCase.execute();

  Future<void> logOut() => sl.get<LogOutUseCase>().execute();
}
