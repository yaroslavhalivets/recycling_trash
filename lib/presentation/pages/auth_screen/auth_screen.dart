import 'package:flutter/cupertino.dart';
import 'package:retrash_app/common_widget/main_button/main_button.dart';
import 'package:retrash_app/common_widget/main_text_field/main_text_field.dart';
import 'package:retrash_app/common_widget/password_field/password_field.dart';
import 'package:retrash_app/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class AuthScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _AuthScreenState();
}

class _AuthScreenState extends BaseState<AuthScreen, AuthBloc> {
  final GlobalKey<FormState> _formState = GlobalKey<FormState>();

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();

  final ValueNotifier<bool> _activeButtonNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    _emailTextEditingController.addListener(_listenFieldState);
    _passwordTextEditingController.addListener(_listenFieldState);
  }

  @override
  Widget body() => SafeArea(
        child: Form(
          key: _formState,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _Logo(),
                MainTextField(
                  textEditingController: _emailTextEditingController,
                  hintText: AppStrings.login,
                  width: MediaQuery.of(context).size.width * 0.9,
                ),
                PasswordField(
                  controller: _passwordTextEditingController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: ValueListenableBuilder<bool>(
                    valueListenable: _activeButtonNotifier,
                    builder: (context, value, _) {
                      return MainButton.fromText(AppStrings.enter,
                          width: MediaQuery.of(context).size.width * 0.9,
                          onTap: value ? onTap : null);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  @override
  void dispose() {
    _emailTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _activeButtonNotifier.dispose();
    super.dispose();
  }

  @override
  AuthBloc provideBloc() => AuthBloc();

  @override
  Color? backgroundColor() => AppColors.lightKhaki;

  bool _validate() {
    return _formState.currentState!.validate();
  }

  void _listenFieldState() {
    _activeButtonNotifier.value =
        _passwordTextEditingController.text.trim().isNotEmpty &&
            _emailTextEditingController.text.trim().isNotEmpty;
  }

  Future<void> onTap() async {
    if (_validate()) {}
  }
}

class _Logo extends StatelessWidget {
  const _Logo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: Image.asset(AppImages.splashLogo),
    );
  }
}
