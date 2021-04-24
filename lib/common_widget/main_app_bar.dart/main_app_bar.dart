import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget child;
  final Color backgroundColor;
  final Color textColor;
  final Widget? leading;

  const MainAppBar(
      {Key? key,
      required this.child,
      required this.backgroundColor,
      required this.textColor,
      this.leading})
      : super(key: key);

  MainAppBar.fromText(String text,
      {this.backgroundColor = AppColors.mantis,
      this.textColor = Colors.white,
      this.leading})
      : child = Text(
          text,
          style: TextStyle(fontSize: 20, color: textColor),
        );

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: child,
      leading: leading,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
