import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_strings/app_strings.dart';

class NotFoundPlaceholder extends StatelessWidget {
  const NotFoundPlaceholder();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsetsDirectional.only(start: 20, top: 20),
          child: Text(
            AppStrings.notFound,
            style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: AppColors.mineShaft,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ],
    );
  }
}