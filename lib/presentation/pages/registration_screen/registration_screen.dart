import 'package:flutter/material.dart';
import 'package:retrash_app/common_widget/leading_app_bar/leading_app_bar.dart';
import 'package:retrash_app/common_widget/registration_navigator/registration_navigator.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/error_dispatcher.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/pages/registration_screen/password_creation_page.dart';
import 'package:retrash_app/presentation/pages/registration_screen/user_info_page.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

const int _initialPage = 0;
const Duration transitionDuration = Duration(microseconds: 270);
const Curve transitionCurve = Curves.bounceInOut;

class RegistrationScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState
    extends BaseState<RegistrationScreen, RegistrationBloc>
    with ErrorDispatcher<RegistrationScreen, RegistrationBloc> {
  final List<String> _labels = [
    AppStrings.generalInformation,
    AppStrings.password,
  ];

  late final PageController _pageViewController;

  double _currentPage = 0.0;

  @override
  PreferredSizeWidget? appBar() =>
      LeadingAppBar.fromText(AppStrings.registration);

  @override
  void initState() {
    super.initState();
    _pageViewController =
        PageController(initialPage: _initialPage, keepPage: true);
  }

  @override
  Widget body() => SafeArea(
        child: Stack(
          children: [
            _registrationNavigator(),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: PageView(
                controller: _pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  UserInfoPage(
                    pageController: _pageViewController,
                    transitionDuration: transitionDuration,
                    transitionCurve: transitionCurve,
                  ),
                  PasswordCreationPage(
                    pageController: _pageViewController,
                    transitionDuration: transitionDuration,
                    transitionCurve: transitionCurve,
                  )
                ],
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page.toDouble();
                  });
                },
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    _pageViewController.dispose();
    super.dispose();
  }

  @override
  RegistrationBloc provideBloc() => RegistrationBloc();

  RegistrationNavigator _registrationNavigator() =>
      RegistrationNavigator(currentPage: _currentPage, labels: _labels);
}
