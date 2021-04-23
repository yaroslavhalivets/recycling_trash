import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:retrash_app/common_widget/error_parser/error_parser.dart';
import 'package:retrash_app/common_widget/main_button/main_button.dart';
import 'package:retrash_app/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/data/requests/auth_request.dart';
import 'package:retrash_app/presentation/bloc/bloc_provider.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/pages/registration_screen/complete_registration_page.dart';
import 'package:retrash_app/presentation/pages/registration_screen/page_position.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';
import 'package:retrash_app/utils/page_view_animation_settings.dart';
import 'package:retrash_app/utils/patterns.dart';

const _passwordMinLength = 9;

class PasswordCreationScreen extends StatefulWidget {
  final PageController pageController;

  const PasswordCreationScreen({Key? key, required this.pageController})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _PasswordCreationScreenState();
}

class _PasswordCreationScreenState extends State<PasswordCreationScreen> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController _passwordEditingController =
      TextEditingController();
  final TextEditingController _repeatPasswordEditingController =
      TextEditingController();

  final ValueNotifier<String> _errorNotifier = ValueNotifier<String>('');

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formState,
        child: Column(
          children: [
            MainTextField(
              textEditingController: _passwordEditingController,
              hintText: AppStrings.password,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.passwordValidation(text),
              error: AppStrings.invalidPassword,
              formatter: [
                LengthLimitingTextInputFormatter(_passwordMinLength),
                FilteringTextInputFormatter.allow(Patterns.password)
              ],
            ),
            MainTextField(
              textEditingController: _repeatPasswordEditingController,
              hintText: AppStrings.approve,
              width: MediaQuery.of(context).size.width * 0.9,
              isValid: (text) => Patterns.passwordValidation(text),
              error: AppStrings.invalidPassword,
              formatter: [
                LengthLimitingTextInputFormatter(_passwordMinLength),
                FilteringTextInputFormatter.allow(Patterns.password)
              ],
            ),
            ErrorParser(notifier: _errorNotifier),
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
                const SizedBox(
                  width: 10.0,
                ),
                MainButton.fromText(AppStrings.finishRegistration,
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
    _errorNotifier.dispose();
    super.dispose();
  }

  bool _validate() =>
      _passwordEditingController.text.trim() ==
      _repeatPasswordEditingController.text.trim();

  Future<void> _onFinishTap() async {
    if (_formState.currentState!.validate() && _validate()) {
      _formState.currentState!.save();

      var bloc = BlocProvider.of<RegistrationBloc>(context);
      AuthRequest request = bloc.authRequest;
      request.password = _passwordEditingController.text.trim();
      if (!request.isEmpty()) {
        await bloc.signUp(request).then((_) {
          Navigator.of(context).push(MaterialPageRoute(
              builder: (_) => const CompleteRegistrationPage()));
        });
      }
    } else {
      _errorMessage(AppStrings.notMatch);
    }
  }

  Future<void> _onBackTap() async {
    await widget.pageController.animateToPage(PagePosition.firstPageIndex,
        duration: PageViewAnimationSettings.transitionDuration,
        curve: PageViewAnimationSettings.transitionCurve);
  }

  void _errorMessage(String message) {
    _errorNotifier.value = message;
  }
}
