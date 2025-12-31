import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SendButtonWidget extends StatelessWidget {
  const SendButtonWidget({super.key, required this.resetPasswordCubit});

  final ResetPasswordCubit resetPasswordCubit;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: EdgeInsetsDirectional.only(end: 110.w),
        child: SizedBox(
          width: 154.w,
          height: 56.h,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                resetPasswordCubit.forgetPasswordCubit();
              },
              backgroundColor: AppColors.loginButtonColor,
              radius: 25,
              customText: CustomText(
                title: "send".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.white,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
