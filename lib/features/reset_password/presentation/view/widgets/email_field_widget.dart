import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class EmailFieldWidget extends StatelessWidget {
  const EmailFieldWidget({super.key, required this.resetPasswordCubit});

  final ResetPasswordCubit resetPasswordCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 388.w,
      child: CustomTextFormField(
        textFieldModel: TextFieldModel(
          customTextLabel: CustomText(
            title: "emailAddress".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: AppColors.aiModelColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          onFieldSubmitted: (submit) {
            resetPasswordCubit.forgetPasswordCubit();
          },
          hintText: "enterEmail".tr(),
          controller: resetPasswordCubit.emailController,
          focusNode: resetPasswordCubit.emailNode,
          keyboardType: TextInputType.emailAddress,
          validator: (email) => MyValidators.emailValidator(email),
        ),
      ),
    );
  }
}
