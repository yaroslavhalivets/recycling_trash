import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/animated_list_tile/animated_list_tile.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/help_screen/help_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class HelpScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _HelpScreenState();
}

class _HelpScreenState extends BaseState<HelpScreen, HelpBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.help, onLeadingTap: () {
        Scaffold.of(context).openDrawer();
      });

  @override
  Widget body() => PageView(
    children: <Widget>[
      Container(
        color: Colors.pink,
      ),
      Container(
        color: Colors.cyan,
      ),
      Container(
        color: Colors.deepPurple,
      ),
    ],
  );

  @override
  HelpBloc provideBloc() => HelpBloc();
}
