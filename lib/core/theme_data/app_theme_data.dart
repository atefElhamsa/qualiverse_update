import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

// Defines the application's theme data for both light and dark modes.
class AppThemeData {
  // Light theme configuration.
  static final ThemeData lightTheme = ThemeData(
    // Sets the overall brightness to light.
    brightness: Brightness.light,
    // Sets the background color for scaffold widgets.
    scaffoldBackgroundColor: AppColors.white,
    // Sets the focus color.
    focusColor: AppColors.white,
    colorScheme: const ColorScheme.light(
      onPrimary: AppColors.grey,
      // Color for text/icons on primary color surfaces.
      onSecondary: AppColors.mainBlack,
      onSecondaryContainer: AppColors.scaffoldLight1,
      onSecondaryFixed: AppColors.grey,
      onPrimaryContainer: AppColors.greyLight,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.tajawal(
        fontSize: 50.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.black,
      ),
      displayMedium: GoogleFonts.tajawal(
        fontSize: 42.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.black,
      ),
      displaySmall: GoogleFonts.tajawal(
        fontSize: 26.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.black,
      ),
      headlineLarge: GoogleFonts.tajawal(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.black,
      ),
      titleLarge: GoogleFonts.tajawal(
        fontSize: 50.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.black,
      ),
      bodyMedium: GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.black,
      ),
      headlineMedium: GoogleFonts.tajawal(
        fontSize: 34.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelLarge: GoogleFonts.tajawal(
        fontSize: 52.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.mainBlack,
      ),
      headlineSmall: GoogleFonts.tajawal(
        fontSize: 34.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.mainBlack,
      ),
      bodySmall: GoogleFonts.tajawal(
        fontSize: 18.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.mainBlack,
      ),
      labelSmall: GoogleFonts.tajawal(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.redLight,
      ),
      titleSmall: GoogleFonts.tajawal(
        fontSize: 22.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.colorButtonLight,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.colorButtonLight,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      // filled: true,
      // fillColor: AppColors.grey,
      hintStyle: GoogleFonts.tajawal(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.grey,
      ),
      // Outline border styles for input fields.
      enabledBorder: outlineInputBorder(AppColors.greyLight.withOpacity(0.75)),
      focusedBorder: outlineInputBorder(AppColors.greyLight.withOpacity(0.75)),
      errorBorder: outlineInputBorder(AppColors.greyLight.withOpacity(0.75)),
      focusedErrorBorder: outlineInputBorder(
        AppColors.greyLight.withOpacity(0.75),
      ),
      // Color for the suffix icon in input fields.
      suffixIconColor: AppColors.mainBlack,
      // Style for error messages in input fields.
      errorStyle: GoogleFonts.tajawal(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.red,
      ),
    ),
  );
}

// Helper function to create an OutlineInputBorder with a specified color and rounded corners.
OutlineInputBorder outlineInputBorder(Color color) {
  return OutlineInputBorder(borderSide: BorderSide(color: color, width: 2));
}
