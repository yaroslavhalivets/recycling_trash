import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';

class UnderlinedTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color textColor;

  const UnderlinedTextButton(
      {Key? key, required this.onTap, required this.text, required this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onTap,
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1?.copyWith(
              color: textColor,
              fontSize: 16.0,
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.mantis.withOpacity(0.5),
              decorationThickness: 6.0),
          overflow: TextOverflow.visible,
          textAlign: TextAlign.start,
        ));
  }
}
