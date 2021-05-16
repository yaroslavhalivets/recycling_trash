import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';

class ErrorParser extends StatelessWidget {
  final ValueNotifier<String> notifier;
  final EdgeInsets padding;

  const ErrorParser({Key? key, required this.notifier, required this.padding})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: padding,
        child: ValueListenableBuilder<String>(
            valueListenable: notifier,
            builder: (BuildContext context, value, _) {
              if (value.isEmpty) {
                return const SizedBox.shrink();
              }
              return Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .button
                      ?.copyWith(color: AppColors.coral));
            }));
  }
}
