import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:retrash_app/common_widget/main_button/main_button.dart';
import 'package:retrash_app/presentation/pages/home_screen/home_screen.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class CompleteRegistrationPage extends StatelessWidget {
  const CompleteRegistrationPage();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Container(
          color: AppColors.mantis,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              SvgPicture.asset(AppImages.done),
              const SizedBox(
                height: 30.0,
              ),
              Text(AppStrings.registrationIsCompleted,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: AppColors.surface,
                      )),
              const Spacer(),
              MainButton.fromText(AppStrings.enter,
                  height: 54.0,
                  width: MediaQuery.of(context).size.width * 0.9,
                  textColor: AppColors.mantis,
                  mainColor: AppColors.surface,
                  onTap: () => _navigateToHomeScreen(context)),
              const SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  _navigateToHomeScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => HomeScreen(),
        ));
  }
}
