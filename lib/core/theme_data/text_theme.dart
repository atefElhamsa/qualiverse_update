import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

TextTheme getAppTextTheme() => TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 48.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.black,
      ),
      displayMedium: GoogleFonts.cairo(
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      displaySmall: GoogleFonts.cairo(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleLarge: GoogleFonts.cairo(
        fontSize: 48.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.black,
      ),
      bodyMedium: GoogleFonts.cairo(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      headlineMedium: GoogleFonts.cairo(
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelLarge: GoogleFonts.cairo(
        fontSize: 50.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.mainBlack,
      ),
      headlineSmall: GoogleFonts.cairo(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mainBlack,
      ),
      bodySmall: GoogleFonts.cairo(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mainBlack,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.redLight,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorButtonLight,
      ),
    );
