import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

void showSnackBar(BuildContext context, String title, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: CustomText(
        title: title,
        textStyle: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: AppColors.white),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: color,
      showCloseIcon: true,
      closeIconColor: AppColors.white,
    ),
  );
}
