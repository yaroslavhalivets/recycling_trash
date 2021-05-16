import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer.dart';
import 'package:retrash_app/presentation/screens/map_screen/map_screen.dart';
import 'package:retrash_app/presentation/screens/presents_screen/presents_screen.dart';
import 'package:retrash_app/presentation/screens/qr_screen/qr_screen.dart';

import 'home_bloc.dart';

const _initTab = 1;

class HomeScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseState<HomeScreen, HomeBloc> {
  late ValueNotifier<int> notifier;

  List<BottomNavigationBarItem> _tabs = <BottomNavigationBarItem>[
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppImages.dollarIcon)),
        label: AppStrings.prices),
    BottomNavigationBarItem(
      icon: ImageIcon(AssetImage(AppImages.mapIcon)),
      label: AppStrings.map,
      activeIcon: Container(
        height: 25.0,
      ),
    ),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage(AppImages.qrIcon)), label: AppStrings.qr),
  ];

  @override
  void initState() {
    super.initState();
    notifier = ValueNotifier(_initTab);
  }

  @override
  Widget body() => _TabPages(
        notifier: notifier,
      );

  @override
  void dispose() {
    notifier.dispose();
    super.dispose();
  }

  @override
  HomeBloc provideBloc() => HomeBloc();

  @override
  Widget drawer() => AppDrawer();

  @override
  Widget floatingActionButton() => ValueListenableBuilder<int>(
        valueListenable: notifier,
        builder: (BuildContext context, value, _) {
          return _getFloatingTab(value);
        },
      );

  @override
  Widget bottomNavigationBar() => ValueListenableBuilder<int>(
        valueListenable: notifier,
        builder: (BuildContext context, value, _) {
          return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: value,
            selectedItemColor: AppColors.lightKhaki,
            backgroundColor: AppColors.mantis,
            items: _tabs,
            onTap: (int i) {
              notifier.value = i;
            },
          );
        },
      );

  Widget _getFloatingTab(int currentIndex) {
    if (currentIndex == 1) {
      return Container(
        height: 48.0,
        width: 48.0,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.mantis,
            border: Border.all(color: Colors.white, width: 2.0)),
        child: Center(
          child: Image.asset(
            AppImages.mapColored,
            width: 30.0,
          ),
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}

class _TabPages extends StatelessWidget {
  final ValueNotifier<int> notifier;
  final List<Widget> tabs;

  _TabPages({required this.notifier}) : tabs = _buildTabs();

  static List<Widget> _buildTabs() {
    return <Widget>[
      Navigator(
        key: ValueKey('Presents_screen'),
        onGenerateRoute: (_) {
          return MaterialPageRoute(builder: (_) => PresentsScreen());
        },
      ),
      Navigator(
        key: ValueKey('Map_screen'),
        onGenerateRoute: (_) {
          return MaterialPageRoute(builder: (_) => MapScreen());
        },
      ),
      Navigator(
        key: ValueKey('Qr_screen'),
        onGenerateRoute: (_) {
          return MaterialPageRoute(builder: (_) => QrScreen());
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: notifier,
      builder: (BuildContext context, value, _) {
        return IndexedStack(
          index: value,
          children: tabs,
        );
      },
    );
  }
}
