import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/map_screen/map_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class MapScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _MapScreenState();
}

class _MapScreenState extends BaseState<MapScreen, MapBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.map, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => Column();

  @override
  MapBloc provideBloc() => MapBloc();
}
