import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors/app_colors.dart';

class MainAppBar extends StatelessWidget with PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.mantis,
      automaticallyImplyLeading: false,
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(56.0);
}
