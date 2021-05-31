import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/common_widget/main_app_bar.dart/main_app_bar.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/screens/app_drawer/app_drawer.dart';
import 'package:retrash_app/presentation/screens/help_screen/help_bloc.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class HelpScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _HelpScreenState();
}

const Size _carouselDotSize = Size(15, 15);
const double _dotHorizontalPadding = 15.0;

class _HelpScreenState extends BaseState<HelpScreen, HelpBloc> {
  @override
  PreferredSizeWidget? appBar() =>
      MainAppBar.fromMenu(AppStrings.help, onLeadingTap: () {
        scaffoldKey.currentState!.openDrawer();
      });

  @override
  Widget? drawer() => AppDrawer();

  final PageController _pageController = PageController();
  double _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget body() => DecoratedBox(
        decoration: BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 30,
              child: DotsIndicator(
                dotsCount: 3,
                position: _currentPage,
                decorator: DotsDecorator(
                  size: _carouselDotSize,
                  activeSize: _carouselDotSize,
                  activeColor: AppColors.mantis,
                  color: AppColors.mantis.withOpacity(0.3),
                  spacing: const EdgeInsets.symmetric(
                      horizontal: _dotHorizontalPadding),
                ),
              ),
            ),
            Expanded(
              child: PageView(
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page.toDouble();
                  });
                },
                children: [
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    color: Colors.white,
                  ),
                  Container(
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  @override
  HelpBloc provideBloc() => HelpBloc();
}
