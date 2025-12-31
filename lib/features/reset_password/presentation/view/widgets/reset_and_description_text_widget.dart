import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class ResetAndDescriptionTextWidget extends StatelessWidget {
  const ResetAndDescriptionTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "resetYourPassword".tr(),
          textStyle: GoogleFonts.inter(
            fontSize: 36.sp,
            color: AppColors.mainBlack,
            fontWeight: FontWeight.w600,
          ),
        ),
        CustomText(
          title: "checkEmail".tr(),
          textStyle: GoogleFonts.inter(
            fontSize: 12.sp,
            color: AppColors.descResetColor,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
