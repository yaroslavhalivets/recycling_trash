import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';

class LeadingAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget child;
  final Color backgroundColor;
  final Color arrowBackColor;
  final Color textColor;

  const LeadingAppBar(
      {Key? key,
      required this.child,
      required this.backgroundColor,
      required this.arrowBackColor,
      required this.textColor})
      : super(key: key);

  LeadingAppBar.fromText(String text,
      {this.backgroundColor = AppColors.mantis,
      this.arrowBackColor = Colors.white,
      this.textColor = Colors.white})
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
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back, color: arrowBackColor),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
