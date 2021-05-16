import 'package:retrash_app/domain/interactor/check_auth_use_case.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';
import 'package:rx_command/rx_command.dart';

import '../../../main.dart';

class SplashBloc extends BaseBloc {
  final checkAuth = RxCommand.createAsyncNoParam<bool>(
      () => sl.get<CheckAuthUseCase>().execute(),
      emitsLastValueToNewSubscriptions: true);

  @override
  void init() {
    super.init();
    checkAuth.thrownExceptions.listen((error) => errorSink.add(error));
  }

  @override
  void dispose() {
    checkAuth.dispose();
    super.dispose();
  }
}
