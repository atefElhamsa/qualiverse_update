import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void showSnackBar(BuildContext context, String title, Color color) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      behavior: SnackBarBehavior.floating,
      duration: const Duration(seconds: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
      backgroundColor: color,
      showCloseIcon: true,
    ),
  );
}
