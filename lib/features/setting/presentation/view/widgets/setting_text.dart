import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class SettingText extends StatelessWidget {
  const SettingText({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return Positioned(
      top: 137.h,
      right: 501.w,
      child: CustomText(
        title: "settings".tr(),
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          fontSize: 64.sp,
          fontWeight: FontWeight.w900,
          color: AppColors.mainBlack,
        ),
      ),
    );
  }
}
