import 'package:firebase_auth/firebase_auth.dart';
import 'package:retrash_app/data/api/uid.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/domain/injectors/sign_up_use_case.dart';
import 'package:retrash_app/main.dart';
import 'package:retrash_app/presentation/bloc/base_bloc.dart';

class RegistrationBloc extends BaseBloc {
  final SignUpUseCase _signUpUseCase = sl.get<SignUpUseCase>();

  final AuthRequest authRequest = AuthRequest.empty();

  Future<UserCredential> signUp(AuthRequest request) {
    return _signUpUseCase.signUp(request).catchError((e) {
      dispatchError(e);
    });
  }

  Future<void> saveUid(UserCredential credential) async {
    String? uid = credential.user?.uid;
    await _signUpUseCase.saveUid(Uid(uid));
  }
}
