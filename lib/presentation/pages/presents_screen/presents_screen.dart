import 'package:flutter/cupertino.dart';
import 'package:retrash_app/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/presents_bloc/presents_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class PresentsScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _PresentsScreenState();
}

class _PresentsScreenState extends BaseState<PresentsScreen, PresentsBloc> {

  @override
  PreferredSizeWidget? appBar() => MainAppBar.fromText(AppStrings.prices);

  @override
  Widget body() => Column();

  @override
  PresentsBloc provideBloc() => PresentsBloc();
}
