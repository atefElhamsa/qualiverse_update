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
      hintStyle: GoogleFonts.cairo(
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
      errorStyle: GoogleFonts.cairo(
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.red,
      ),
    ),
  );

  // Dark theme configuration.
  static final ThemeData darkTheme = ThemeData(
    // Sets the overall brightness to dark.
    brightness: Brightness.dark,
    // Sets the background color for scaffold widgets.
    scaffoldBackgroundColor: AppColors.black,
    focusColor: AppColors.transparent,
    // Sets the focus color.
    colorScheme: const ColorScheme.dark(
      onPrimary: AppColors.textFieldDark,
      onSecondary: AppColors.white,
      onSecondaryContainer: AppColors.colorButtonDark,
      onSecondaryFixed: AppColors.textFieldDark,
      onPrimaryContainer: AppColors.textFieldDark,
    ),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.inter(
        fontSize: 48.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.white,
      ),
      displayMedium: GoogleFonts.cairo(
        fontSize: 40.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      displaySmall: GoogleFonts.cairo(
        fontSize: 24.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
      headlineLarge: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      titleLarge: GoogleFonts.cairo(
        fontSize: 48.sp,
        fontWeight: FontWeight.w900,
        color: AppColors.white,
      ),
      bodyMedium: GoogleFonts.cairo(
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.white,
      ),
      headlineMedium: GoogleFonts.cairo(
        fontSize: 32.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
      labelLarge: GoogleFonts.cairo(
        fontSize: 50.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.white,
      ),
      headlineSmall: GoogleFonts.cairo(
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
      ),
      bodySmall: GoogleFonts.cairo(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 20.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.redLight,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.colorButtonDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.r),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.textFieldDark,
      hintStyle: GoogleFonts.cairo(
        fontSize: 16.sp,
        fontWeight: FontWeight.w400,
        color: AppColors.white,
      ),
      enabledBorder: outlineInputBorder(AppColors.textFieldDark),
      focusedBorder: outlineInputBorder(AppColors.textFieldDark),
      errorBorder: outlineInputBorder(AppColors.textFieldDark),
      focusedErrorBorder: outlineInputBorder(AppColors.textFieldDark),
      // Color for the suffix icon in input fields (dark theme).
      suffixIconColor: AppColors.white,
      // Style for error messages in input fields (dark theme).
      errorStyle: GoogleFonts.cairo(
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
