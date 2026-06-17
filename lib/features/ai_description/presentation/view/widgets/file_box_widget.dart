import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class FileBoxWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isReady;

  const FileBoxWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
      width: 350.w,
      height: 160.h,
      decoration: BoxDecoration(
        color: isReady ? Colors.white : AppColors.aiBoxBg,
        gradient: isReady
            ? LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  iconColor.withAlpha(20), // Slight tint
                  Colors.white,
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(
          color: isReady ? iconColor.withAlpha(50) : AppColors.greyLight.withAlpha(100),
          width: 1.5,
        ),
        boxShadow: isReady
            ? [
                BoxShadow(
                  color: iconColor.withAlpha(40),
                  blurRadius: 25,
                  spreadRadius: -5,
                  offset: const Offset(0, 10),
                ),
              ]
            : [],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: isReady ? iconColor.withAlpha(25) : Colors.transparent,
              shape: BoxShape.circle,
              border: isReady ? null : Border.all(color: AppColors.greyLight, width: 1.5),
            ),
            child: Icon(
              icon,
              size: 45.sp,
              color: isReady ? iconColor : AppColors.greyLight,
            ),
          ),
          SizedBox(height: 12.h),
          if (isReady) _buildReadyLabel() else _buildPreparingLabel(),
        ],
      ),
    );
  }

  Widget _buildReadyLabel() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              color: AppColors.aiSuccess.withAlpha(25),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle_rounded,
              color: AppColors.aiSuccess,
              size: 14,
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: GoogleFonts.almarai(
              color: AppColors.textFieldDark,
              fontSize: 20.sp,
              fontWeight: FontWeight.w800,
              letterSpacing: 0.5,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ],
      ),
    );
  }

  Widget _buildPreparingLabel() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 14.w,
          height: 14.w,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            color: AppColors.greyLight,
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          "preparing".tr(),
          style: GoogleFonts.almarai(
            color: AppColors.greyLight,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
