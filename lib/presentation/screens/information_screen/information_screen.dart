import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/animated_list_tile/animated_list_tile.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/information_screen/information_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class InformationScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _InformationScreenState();
}

class _InformationScreenState
    extends BaseState<InformationScreen, InformationBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.information, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => ListView(
        children: [
          AnimatedListTile(),
          AnimatedListTile(),
          AnimatedListTile(),
          AnimatedListTile(),
          AnimatedListTile(),
        ],
      );

  @override
  InformationBloc provideBloc() => InformationBloc();
}
