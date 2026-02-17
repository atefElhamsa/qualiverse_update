import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FieldsWidget extends StatelessWidget {
  const FieldsWidget({super.key, required this.loginCubit});

  final LoginCubit loginCubit;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: 388.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              customTextLabel: CustomText(
                title: "userNameOrEmail".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (submit) {
                FocusScope.of(context).requestFocus(loginCubit.passwordNode);
              },
              hintText: "enterUserNameOrEmail".tr(),
              controller: loginCubit.userNameOrEmailController,
              focusNode: loginCubit.userNameOrEmailNode,
              keyboardType: TextInputType.emailAddress,
              validator: (emailOrUserName) =>
                  MyValidators.userNameOrEmailValidator(emailOrUserName),
            ),
          ),
        ),
        const SizedBox(height: 31),
        SizedBox(
          width: 388.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              customTextLabel: CustomText(
                title: "password".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              focusNode: loginCubit.passwordNode,
              isObscured: true,
              onFieldSubmitted: (submit) {
                loginCubit.loginCubit(context);
              },
              hintText: "enterPassword".tr(),
              controller: loginCubit.passwordController,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) => MyValidators.passwordValidator(password),
            ),
          ),
        ),
      ],
    );
  }
}
