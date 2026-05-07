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
      displayMedium: GoogleFonts.almarai(
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      displaySmall: GoogleFonts.almarai(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleLarge: GoogleFonts.almarai(
        fontSize: 48.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.black,
      ),
      bodyMedium: GoogleFonts.almarai(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      headlineMedium: GoogleFonts.almarai(
        fontSize: 32.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      labelLarge: GoogleFonts.almarai(
        fontSize: 50.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.mainBlack,
      ),
      headlineSmall: GoogleFonts.almarai(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mainBlack,
      ),
      bodySmall: GoogleFonts.almarai(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.mainBlack,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.redLight,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorButtonLight,
      ),
    );
