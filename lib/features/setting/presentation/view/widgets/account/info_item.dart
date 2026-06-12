import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.label,
    required this.value,
    required this.showChange,
    required this.icon,
    this.onPressed,
    this.trailing,
  });

  final String label;
  final String value;
  final bool showChange;
  final IconData icon;
  final VoidCallback? onPressed;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).scaffoldBackgroundColor == AppColors.white;
    final labelColor = isLight ? AppColors.textGrey : AppColors.greyLight;
    final valueColor = isLight ? AppColors.textBlack : AppColors.white;
    final iconColor = isLight ? AppColors.blue : AppColors.selectedItemColor1;
    final iconBg = isLight 
        ? AppColors.blue.withOpacity(0.1) 
        : AppColors.selectedItemColor1.withOpacity(0.1);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon Container
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 22.r,
            ),
          ),
          SizedBox(width: 16.w),
          // Stacked Label and Value
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  label.tr(),
                  style: GoogleFonts.inter(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: labelColor,
                  ),
                ),
                SizedBox(height: 4.h),
                if (trailing != null)
                  trailing!
                else
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: valueColor,
                    ),
                  ),
              ],
            ),
          ),
          if (showChange) ...[
            SizedBox(width: 12.w),
            TextButton(
              onPressed: onPressed,
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                backgroundColor: isLight 
                    ? AppColors.blue.withOpacity(0.08) 
                    : AppColors.white.withOpacity(0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.edit_rounded,
                    size: 14.r,
                    color: isLight ? AppColors.blue : AppColors.white,
                  ),
                  SizedBox(width: 4.w),
                  CustomText(
                    title: "change".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w600,
                      color: isLight ? AppColors.blue : AppColors.white,
                    ),
                  ),
                ],
              ),
            ),
          ]
        ],
      ),
    );
  }
}

String maskPassword(String password) {
  return '*' * password.length;
}
