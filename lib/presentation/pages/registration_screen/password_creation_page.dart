import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:retrash_app/common_widget/main_button/main_button.dart';
import 'package:retrash_app/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/pages/home_screen/home_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';
import 'package:retrash_app/utils/patterns.dart';

class PasswordCreationPage extends StatefulWidget {
  final PageController pageController;
  final Duration transitionDuration;
  final Curve transitionCurve;

  const PasswordCreationPage(
      {Key? key,
      required this.pageController,
      required this.transitionDuration,
      required this.transitionCurve})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordCreationPageState();
}

class _PasswordCreationPageState extends State<PasswordCreationPage> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _repeatPasswordEditingController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formState,
        child: Column(
          children: [
            MainTextField(
              padding: const EdgeInsets.only(top: 20.0),
              textEditingController: _passwordEditingController,
              hintText: AppStrings.password,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.password.hasMatch(text),
              error: AppStrings.passwordLessThen8Symbols,
              formatter: [
                FilteringTextInputFormatter.deny(Patterns.passwordDisAllow),
              ],
            ),
            MainTextField(
              padding: const EdgeInsets.only(top: 20.0),
              textEditingController: _repeatPasswordEditingController,
              hintText: AppStrings.approve,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.password.hasMatch(text),
              error: AppStrings.passwordLessThen8Symbols,
              formatter: [
                FilteringTextInputFormatter.deny(Patterns.passwordDisAllow),
              ],
            ),
            const SizedBox(
              height: 30.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                MainButton.fromText(AppStrings.back,
                    mainColor: AppColors.surface,
                    textColor: AppColors.mantis,
                    boxBorder: Border.all(color: AppColors.mineShaft),
                    width: MediaQuery.of(context).size.width * 0.43,
                    onTap: _onBackTap),
                MainButton.fromText(AppStrings.finishRegistration,
                    padding: const EdgeInsets.only(left: 10.0),
                    onDone: _onDone,
                    width: MediaQuery.of(context).size.width * 0.43,
                    onTap: _onFinishTap),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _passwordEditingController.dispose();
    _repeatPasswordEditingController.dispose();
    super.dispose();
  }

  bool _validate() =>
      _passwordEditingController.text.trim() ==
      _repeatPasswordEditingController.text.trim();

  Future<void> _onFinishTap() async {
    var bloc = BlocProvider.of<RegistrationBloc>(context);
    if (_formState.currentState!.validate()) {
      if (_validate()) {
        AuthRequest request = bloc.authRequest;
        request.password = _passwordEditingController.text.trim();
        if (!request.isEmpty()) {
          return bloc.signUp(request);
        }
      } else {
        bloc.dispatchError(AppStrings.passwordNotMatch);
      }
    }
  }

  void _onDone() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  }

  Future<void> _onBackTap() async {
    await widget.pageController.previousPage(
        duration: widget.transitionDuration, curve: widget.transitionCurve);
  }
}
