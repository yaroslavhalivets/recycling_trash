import 'package:flutter/cupertino.dart';
import 'package:retrash_app/common_widget/animated_list_tile/animated_list_tile.dart';
import 'package:retrash_app/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/information_bloc/information_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class InformationScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _InformationScreenState();
}

class _InformationScreenState
    extends BaseState<InformationScreen, InformationBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(context, AppStrings.information);

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
