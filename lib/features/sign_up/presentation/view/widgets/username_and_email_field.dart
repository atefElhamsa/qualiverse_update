import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class UsernameAndEmailField extends StatelessWidget {
  const UsernameAndEmailField({super.key, required this.signUpCubit});

  final SignUpCubit signUpCubit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 200.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              customTextLabel: CustomText(
                title: "userName".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (submit) {
                FocusScope.of(context).requestFocus(signUpCubit.emailNode);
              },
              hintText: "enterUsername".tr(),
              controller: signUpCubit.userNameController,
              focusNode: signUpCubit.userNameNode,
              keyboardType: TextInputType.name,
              validator: (email) => MyValidators.displayNameValidator(email),
            ),
          ),
        ),
        SizedBox(width: 10.w),
        SizedBox(
          width: 200.w,
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
      ],
    );
  }
}
