import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/injectors/user_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class RegistrationBloc extends BaseBloc {
  final UserUseCase _userUseCase = sl.get<UserUseCase>();

  final AuthRequest authRequest = AuthRequest.empty();

  Future<void> signUp(AuthRequest request) async {
    await _userUseCase.signUp(request).catchError((e) {
      dispatchError(e);
    });
  }
}
