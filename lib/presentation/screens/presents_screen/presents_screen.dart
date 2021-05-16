import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/presents_screen/presents_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class PresentsScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _PresentsScreenState();
}

class _PresentsScreenState extends BaseState<PresentsScreen, PresentsBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.prices, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => Column();

  @override
  PresentsBloc provideBloc() => PresentsBloc();
}
