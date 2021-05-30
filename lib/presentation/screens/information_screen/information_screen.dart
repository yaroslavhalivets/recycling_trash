import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/animated_list_tile/animated_list_tile.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer.dart';
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
        scaffoldKey.currentState!.openDrawer();
      });

  @override
  Widget? drawer() => AppDrawer();

  @override
  Widget body() => ListView(
        children: [
          AnimatedListTile(
              fontText: 'Пластик',
              backTitle: 'Пластик',
              backInfo: 'Пластикові пакети, бляшанки',
              backBonuses: '200 бонусів за кілограм пластику'),
          AnimatedListTile(
              fontText: 'Алюміній',
              backTitle: 'Алюміній',
              backInfo: 'Алюмінієві бляшанки',
              backBonuses: '300 бонусів за кілограм алюмінію'),
          AnimatedListTile(
              fontText: 'Скло',
              backTitle: 'Скло',
              backInfo: 'Скляні бляшанки',
              backBonuses: '100 бонусів за кілограм скла'),
          AnimatedListTile(
              fontText: 'Папір',
              backTitle: 'Папір',
              backInfo: 'Макулатура',
              backBonuses: '500 бонусів за кілограм паперу'),
        ],
      );

  @override
  InformationBloc provideBloc() => InformationBloc();
}
