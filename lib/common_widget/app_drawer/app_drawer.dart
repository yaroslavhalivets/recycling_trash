import 'package:flutter/cupertino.dart';
import 'package:retrash_app/presentation/bloc/app_drawer_bloc/app_drawer_bloc.dart';
import 'package:retrash_app/presentation/bloc/base_drawer.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';

class AppDrawer extends BaseDrawer {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends BaseState<AppDrawer, AppDrawerBloc> {
  @override
  Widget body() => Container(
        color: AppColors.surface,
        width: MediaQuery.of(context).size.width * 0.5,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

              ],
            ),
          ),
        ),
      );

  @override
  AppDrawerBloc provideBloc() => AppDrawerBloc();
}
