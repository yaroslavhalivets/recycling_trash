import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/about_screen/about_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer.dart';

class AboutScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _AboutScreenState();
}

class _AboutScreenState extends BaseState<AboutScreen, AboutBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.aboutProgram, onLeadingTap: () {
        scaffoldKey.currentState!.openDrawer();
      });

  @override
  Widget? drawer() => AppDrawer();

  @override
  Widget body() => Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Retrash',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            Text(
              'Цю програму було створено групою студентів з ХНУРЕ для покращення екологічної ситуації в Україні',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Text(
              'Версія 1.0',
              style: Theme.of(context).textTheme.bodyText1,
            )
          ],
        ),
      );

  @override
  AboutBloc provideBloc() => AboutBloc();
}
