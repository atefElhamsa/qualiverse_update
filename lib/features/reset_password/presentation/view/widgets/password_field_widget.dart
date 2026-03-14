import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class PasswordFieldWidget extends StatelessWidget {
  const PasswordFieldWidget({super.key, required this.resetPasswordCubit});

  final ResetPasswordCubit resetPasswordCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 388.w,
      child: CustomTextFormField(
        textFieldModel: TextFieldModel(
          customTextLabel: CustomText(
            title: "newPassword".tr(),
            textStyle: GoogleFonts.inter(
              fontSize: 16.sp,
              color: AppColors.aiModelColor,
              fontWeight: FontWeight.w300,
            ),
          ),
          onFieldSubmitted: (submit) {
            resetPasswordCubit.resetPasswordCubit();
          },
          isObscured: true,
          hintText: "enterYourNewPassword".tr(),
          controller: resetPasswordCubit.passwordController,
          focusNode: resetPasswordCubit.passwordNode,
          keyboardType: TextInputType.visiblePassword,
          validator: (newPassword) =>
              MyValidators.passwordValidator(newPassword),
        ),
      ),
    );
  }
}
