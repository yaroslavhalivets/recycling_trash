import 'dart:io';

import 'package:flutter/material.dart';
import 'package:retrash_app/presentation/resources/app_colors.dart';
import 'package:retrash_app/presentation/resources/app_images.dart';
import 'package:retrash_app/presentation/resources/app_strings.dart';

class PhotoPicker extends StatelessWidget {
  final File? image;
  final VoidCallback onTap;

  const PhotoPicker({Key? key, this.image, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: onTap,
            child: CircleAvatar(
              backgroundColor: AppColors.mineShaft,
              radius: 50,
              backgroundImage: image != null ? FileImage(image!) : null,
              child: image == null
                  ? Image.asset(AppImages.camera, width: 50.0, height: 50.0)
                  : null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              AppStrings.chooseImage,
              style: Theme.of(context).textTheme.bodyText2?.copyWith(
                    color: AppColors.mantis,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
