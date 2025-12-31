import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class EmailAndPasswordAndConfirmPasswordFields extends StatelessWidget {
  const EmailAndPasswordAndConfirmPasswordFields({
    super.key,
    required this.signUpCubit,
  });

  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 410.w,
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
                FocusScope.of(context).requestFocus(signUpCubit.passwordNode);
              },
              hintText: "enterEmail".tr(),
              controller: signUpCubit.emailController,
              focusNode: signUpCubit.emailNode,
              keyboardType: TextInputType.emailAddress,
              validator: (email) => MyValidators.emailValidator(email),
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: 410.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              isObscured: true,
              customTextLabel: CustomText(
                title: "password".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (submit) {
                FocusScope.of(
                  context,
                ).requestFocus(signUpCubit.confirmPasswordNode);
              },
              hintText: "enterPassword".tr(),
              controller: signUpCubit.passwordController,
              focusNode: signUpCubit.passwordNode,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) => MyValidators.passwordValidator(password),
            ),
          ),
        ),
        const SizedBox(height: 25),
        SizedBox(
          width: 410.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              isObscured: true,
              customTextLabel: CustomText(
                title: "confirmPassword".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (submit) {
                signUpCubit.signUpCubit();
              },
              hintText: "enterConfirmPassword".tr(),
              controller: signUpCubit.confirmPasswordController,
              focusNode: signUpCubit.confirmPasswordNode,
              keyboardType: TextInputType.visiblePassword,
              validator: (confirmPassword) =>
                  MyValidators.repeatPasswordValidator(
                    value: confirmPassword?.trim(),
                    password: signUpCubit.passwordController.text.trim(),
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
