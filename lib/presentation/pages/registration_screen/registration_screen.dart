import 'package:flutter/material.dart';
import 'package:retrash_app/common_widget/leading_app_bar/leading_app_bar.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class RegistrationScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState
    extends BaseState<RegistrationScreen, RegistrationBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      LeadingAppBar.fromText(AppStrings.registration);

  @override
  Widget body() => Column();

  @override
  RegistrationBloc provideBloc() => RegistrationBloc();
}
