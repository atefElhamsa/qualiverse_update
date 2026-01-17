import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class AccountVerificationTop extends StatelessWidget {
  const AccountVerificationTop({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      start: 194.w,
      end: 194.w,
      top: 178.h,
      child: Row(
        children: [
          CustomText(
            title: "Account Verification",
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 36.sp),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              context.pop();
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                margin: EdgeInsets.only(left: 4.w, right: 6.w),
                width: 153.w,
                height: 56.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.r),
                  border: Border.all(color: AppColors.progressColor, width: 2),
                ),
                child: Center(
                  child: CustomText(
                    title: "login".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.loginButtonColor,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
