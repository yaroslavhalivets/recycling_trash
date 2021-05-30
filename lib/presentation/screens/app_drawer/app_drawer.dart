import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/screens/about_screen/about_screen.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer_bloc.dart';
import 'package:retrash_app/presentation/bloc/base_drawer.dart';
import 'package:retrash_app/presentation/common_widget/drawer_head/drawer_head.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/presentation/screens/help_screen/help_screen.dart';
import 'package:retrash_app/presentation/screens/information_screen/information_screen.dart';
import 'package:retrash_app/presentation/screens/settings_screen/settings_screen.dart';

class AppDrawer extends BaseDrawer {
  @override
  State<StatefulWidget> createState() => _AppDrawerState();
}

class _AppDrawerState extends BaseState<AppDrawer, AppDrawerBloc> {
  @override
  Widget body() => Container(
        color: AppColors.surface,
        width: MediaQuery.of(context).size.width * 0.7,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const DrawerHead(),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: _DrawerTab(
                      text: AppStrings.information,
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (_) => InformationScreen()));
                      }),
                ),
                _DrawerTab(
                  text: AppStrings.settings,
                  onTap: () {
                    Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsScreen()));
                  },
                ),
                _DrawerTab(text: AppStrings.help, 
                    onTap: () {
                      Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HelpScreen()));
                  }),
                _DrawerTab(text: AppStrings.aboutProgram,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => AboutScreen()));
                    }),
                _DrawerTab(text: AppStrings.changeAccount, onTap: () {}),
                _DrawerTab(text: AppStrings.logOut, onTap: () {}),
              ],
            ),
          ),
        ),
      );

  @override
  AppDrawerBloc provideBloc() => AppDrawerBloc();
}

class _DrawerTab extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const _DrawerTab({Key? key, required this.text, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            Divider(
              color: AppColors.mineShaft.withOpacity(0.5),
            ),
          ],
        ),
      ),
    );
  }
}
