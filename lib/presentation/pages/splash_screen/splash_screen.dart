import 'package:flutter/material.dart';
import 'package:retrash_app/common_widget/loader_indicator/loader_indicator.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen();

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    //TODO: navigate to home page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: AppColors.lightKhaki, body: _body());
  }

  SafeArea _body() => SafeArea(
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
                style: Theme.of(context)
                    .textTheme
                    .headline1!
                    .copyWith(fontSize: 60),
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
}
