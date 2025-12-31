import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class ProfileCardWidget extends StatelessWidget {
  const ProfileCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 450.h,
          width: 360.w,
          decoration: BoxDecoration(
            color: AppColors.whiteGrey,
            borderRadius: BorderRadius.circular(40.r),
          ),
        ),
        Column(
          children: [
            Image.asset(AppImages.settingImage, height: 279.h),
            CustomText(
              title: AppTexts.drOmniaElBarbary,
              textStyle: GoogleFonts.inter(
                fontSize: 40.sp,
                fontWeight: FontWeight.w800,
                color: AppColors.drColor,
              ),
            ),
            CustomText(
              title: AppTexts.isDepartment,
              textStyle: GoogleFonts.inter(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.mainBlack,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
