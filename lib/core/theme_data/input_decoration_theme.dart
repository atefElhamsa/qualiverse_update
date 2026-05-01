import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

InputDecorationTheme getAppInputDecorationTheme() => InputDecorationTheme(
  hintStyle: GoogleFonts.cairo(
    fontSize: 16.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.grey,
  ),
  enabledBorder: _outlineInputBorder(AppColors.greyLight.withOpacity(0.75)),
  focusedBorder: _outlineInputBorder(AppColors.greyLight.withOpacity(0.75)),
  errorBorder: _outlineInputBorder(AppColors.greyLight.withOpacity(0.75)),
  focusedErrorBorder: _outlineInputBorder(
    AppColors.greyLight.withOpacity(0.75),
  ),
  suffixIconColor: AppColors.mainBlack,
  errorStyle: GoogleFonts.cairo(
    fontSize: 14.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.red,
  ),
);

OutlineInputBorder _outlineInputBorder(Color color) {
  return OutlineInputBorder(borderSide: BorderSide(color: color, width: 2));
}
