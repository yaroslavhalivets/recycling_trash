import 'package:flutter/material.dart';
import 'package:retrash_app/common_widget/loader_indicator/loader_indicator.dart';
import 'package:retrash_app/presentation/bloc/base_screen.dart';
import 'package:retrash_app/presentation/bloc/splash_bloc/splash_bloc.dart';
import 'package:retrash_app/presentation/pages/auth_screen/auth_screen.dart';
import 'package:retrash_app/presentation/pages/home_screen/home_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class SplashScreen extends BaseScreen {
  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen, SplashBloc> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () => bloc.checkAuth());
    Future.delayed(Duration(seconds: 2)).then((_) => bloc.checkAuth.listen(
        (isLogged) =>
            isLogged! ? _navigateToHome() : _navigateToLogIn()));
  }

  @override
  Widget body() => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(AppImages.splashLogo),
              const SizedBox(
                height: 15.0,
              ),
              Text(
                AppStrings.appName,
                style: Theme.of(context).textTheme.headline1,
              ),
              Expanded(
                child: const LoadingIndicator(
                  color: AppColors.surface,
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Color? backgroundColor() => AppColors.lightKhaki;

  @override
  SplashBloc provideBloc() => SplashBloc();

  _navigateToLogIn() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => AuthScreen()));
  }

  _navigateToHome() {
    Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomeScreen()));
  }
}
