import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key, required this.signUpCubit});

  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return signUpCubit.state is SignUpLoading
        ? const Center(child: CustomLoading())
        : GestureDetector(
            onTap: () {
              signUpCubit.signUpCubit();
            },
            child: Container(
              width: 154.w,
              height: 56.h,
              margin: EdgeInsets.only(top: 25.h),
              decoration: BoxDecoration(
                color: AppColors.loginButtonColor,
                borderRadius: BorderRadius.circular(4.r),
              ),
              child: Center(
                child: CustomText(
                  title: "signUp".tr().toUpperCase(),
                  textStyle: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w900,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          );
  }
}
