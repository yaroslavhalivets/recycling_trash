import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer.dart';
import 'package:retrash_app/presentation/screens/settings_screen/settings_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class SettingsScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseState<SettingsScreen, SettingsBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.settings, onLeadingTap: () {
        scaffoldKey.currentState!.openDrawer();
      });

  @override
  Widget? drawer() => AppDrawer();

  List<bool> inputs = List.filled(4, true);
  List<String> titles = <String>[
    'Отримувати повідомлення',
    'Підсвічувати індикатор повідомлень',
    'Звук повідомлень',
    'Вмикати геоданні автоматично'
  ];
  void itemChanged(bool val, int index) {
    setState(() {
      inputs[index] = val;
    });
  }

  @override
  SettingsBloc provideBloc() => SettingsBloc();

  @override
  Widget body() => ListView.builder(
      itemCount: inputs.length,
      itemBuilder: (BuildContext context, int index) {
        return Card(
          child: Container(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                CheckboxListTile(
                    value: inputs[index],
                    title: Text(
                        titles[index],
                        style: Theme.of(context).textTheme.bodyText1,
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    onChanged: (bool? val) {
                      itemChanged(val!, index);
                    })
              ],
            ),
          ),
        );
      });
}
