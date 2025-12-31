import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class NotificationCheckDark extends StatelessWidget {
  const NotificationCheckDark({
    super.key,
    required this.selectedDark,
    required this.onThemeChanged,
  });

  final bool selectedDark;
  final ValueChanged<bool> onThemeChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600.w,
      child: ListTile(
        title: CustomText(
          title: "notifications".tr(),
          textStyle: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainBlack,
          ),
        ),
        leading: Image.asset(AppImages.notificationImage),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: "activateDarkMode".tr(),
              textStyle: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.mainBlack,
              ),
            ),
            Checkbox(
              value: selectedDark,
              activeColor: AppColors.white,
              side: const BorderSide(
                style: BorderStyle.solid,
                color: AppColors.progressColor,
                width: 2,
              ),
              checkColor: AppColors.colorButtonLight,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(2.r),
                side: const BorderSide(
                  color: AppColors.progressColor,
                  width: 2,
                ),
              ),
              onChanged: (value) {
                onThemeChanged(value!);
              },
            ),
          ],
        ),
      ),
    );
  }
}
