import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class OtpFieldWidget extends StatelessWidget {
  const OtpFieldWidget({super.key, required this.resetPasswordCubit});

  final ResetPasswordCubit resetPasswordCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 388.w,
      child: CustomTextFormField(
        textFieldModel: TextFieldModel(
          customTextLabel: CustomText(
            title: "otp".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: AppColors.aiModelColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          onFieldSubmitted: (submit) {
            FocusScope.of(
              context,
            ).requestFocus(resetPasswordCubit.passwordNode);
          },
          hintText: "enterOtp".tr(),
          controller: resetPasswordCubit.otpController,
          focusNode: resetPasswordCubit.otpNode,
          keyboardType: TextInputType.number,
          validator: (otp) {
            return null;
          },
        ),
      ),
    );
  }
}
