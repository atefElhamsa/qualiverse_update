import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class ContainerLanguageTopAndButton extends StatelessWidget {
  const ContainerLanguageTopAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText(
          title: "websitesInYourLanguages".tr(),
          textStyle: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w400,
            color: AppColors.black,
          ),
        ),
        Spacer(),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () {
              showAddLanguageBottomSheet(context);
            },
            child: Container(
              height: 40.h,
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: AppColors.transparent,
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(width: 1, color: AppColors.black),
              ),
              child: Center(
                child: CustomText(
                  title: "addLanguages".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.headlineLarge!.copyWith(fontSize: 14.sp),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
