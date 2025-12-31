import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class LoginMemberWidget extends StatelessWidget {
  const LoginMemberWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 350.w, top: 76.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            title: "alreadyMember".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 16.sp),
          ),
          GestureDetector(
            onTap: () {
              context.pop();
            },
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
        ],
      ),
    );
  }
}
