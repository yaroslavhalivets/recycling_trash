import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';

const Size _carouselDotSize = Size(10, 12);
const double _dotHorizontalPadding = 12.0;

class RegistrationNavigator extends StatelessWidget {
  final double currentPage;
  final List<String> labels;

  const RegistrationNavigator(
      {Key? key, required this.currentPage, required this.labels})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DotsIndicator(
              dotsCount: labels.length,
              position: currentPage,
              decorator: DotsDecorator(
                size: _carouselDotSize,
                activeSize: _carouselDotSize,
                activeColor: AppColors.mantis,
                color: AppColors.mantis.withOpacity(0.3),
                spacing: const EdgeInsets.symmetric(
                    horizontal: _dotHorizontalPadding),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.2,
              child: ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(vertical: 5.0),
                  itemCount: labels.length,
                  itemBuilder: (BuildContext context, int i) {
                    if (currentPage == i.toDouble()) {
                      return Text(labels[i],
                          style:
                              Theme.of(context).textTheme.bodyText2?.copyWith(
                                    color: AppColors.mantis,
                                    fontSize: 14.0,
                                  ));
                    } else {
                      const double horizontalPaddingBetweenTwoDots =
                          _dotHorizontalPadding * 2;
                      final double spaceBetweenTwoDots =
                          horizontalPaddingBetweenTwoDots +
                              _carouselDotSize.width;
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
}
