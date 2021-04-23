import 'package:flutter/material.dart';

class UnderlinedTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color textColor;
  final Color decorationColor;
  final EdgeInsets? padding;

  const UnderlinedTextButton(
      {Key? key,
      required this.onPressed,
      required this.text,
      required this.textColor,
      required this.decorationColor,
      this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding ?? EdgeInsets.zero,
        child: TextButton(
            onPressed: onPressed,
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                  color: textColor,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: decorationColor,
                  decorationThickness: 1.0),
              overflow: TextOverflow.visible,
              textAlign: TextAlign.start,
            )));
  }
}
