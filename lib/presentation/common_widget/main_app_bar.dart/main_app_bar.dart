import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  final Widget child;
  final Color backgroundColor;
  final Color textColor;
  final Widget? leading;
  final VoidCallback? onLeadingTap;

  const MainAppBar(
      {Key? key,
      required this.child,
      required this.backgroundColor,
      required this.textColor,
      this.leading, this.onLeadingTap})
      : super(key: key);

  MainAppBar.fromText(String text,
      {this.backgroundColor = AppColors.mantis,
      this.textColor = AppColors.surface,
      this.leading, this.onLeadingTap})
      : child = Text(
          text,
          style: TextStyle(fontSize: 20, color: textColor),
        );

  MainAppBar.fromMenu(String title,
      {this.backgroundColor = AppColors.mantis,
      this.textColor = AppColors.surface, required this.onLeadingTap})
      : leading = IconButton(
          icon: const Icon(Icons.menu, size: 40.0, color: AppColors.surface),
          onPressed: onLeadingTap,
        ),
        child = Text(
          title,
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
