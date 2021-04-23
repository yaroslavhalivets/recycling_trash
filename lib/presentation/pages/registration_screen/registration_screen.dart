import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/common_widget/leading_app_bar/leading_app_bar.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/registration_bloc/registration_bloc.dart';
import 'package:retrash_app/presentation/pages/registration_screen/password_creation_screen.dart';
import 'package:retrash_app/presentation/pages/registration_screen/user_info_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

const int pageCount = 2;
const int initialPage = 0;
const Size carouselDotSize = Size(10, 12);
const double dotHorizontalPadding = 12.0;

class RegistrationScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState
    extends BaseState<RegistrationScreen, RegistrationBloc> {
  late PageController _pageViewController;

  double _currentPage = 0.0;

  @override
  PreferredSizeWidget? appBar() =>
      LeadingAppBar.fromText(AppStrings.registration);

  List<String> _stepsCount = [
    AppStrings.step1,
    AppStrings.step2,
  ];

  @override
  void initState() {
    super.initState();
    _pageViewController =
        PageController(initialPage: initialPage, keepPage: false);
  }

  @override
  Widget body() => SafeArea(
        child: Stack(
          children: [
            _dotsIndicator(),
            Padding(
              padding: const EdgeInsets.only(top: 70.0),
              child: PageView(
                controller: _pageViewController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  UserInfoScreen(
                    pageController: _pageViewController,
                  ),
                  PasswordCreationScreen(
                    pageController: _pageViewController,
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

  Align _dotsIndicator() => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              DotsIndicator(
                dotsCount: pageCount,
                position: _currentPage,
                decorator: DotsDecorator(
                  size: carouselDotSize,
                  activeSize: carouselDotSize,
                  activeColor: AppColors.mantis,
                  color: AppColors.mantis.withOpacity(0.3),
                  spacing: const EdgeInsets.symmetric(
                      horizontal: dotHorizontalPadding),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.2,
                child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(vertical: 5.0),
                    itemCount: _stepsCount.length,
                    itemBuilder: (BuildContext context, int i) {
                      if (_currentPage == i.toDouble()) {
                        return Text(_stepsCount[i],
                            style:
                                Theme.of(context).textTheme.bodyText2?.copyWith(
                                      color: AppColors.mantis,
                                      fontSize: 14.0,
                                    ));
                      } else {
                        const double horizontalPaddingBetweenTwoDots =
                            dotHorizontalPadding * 2;
                        final double spaceBetweenTwoDots =
                            horizontalPaddingBetweenTwoDots +
                                carouselDotSize.width;
                        return SizedBox(
                          width: spaceBetweenTwoDots,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      );
}
