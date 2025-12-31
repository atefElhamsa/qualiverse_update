import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FirstAndLastNameFields extends StatelessWidget {
  const FirstAndLastNameFields({super.key, required this.signUpCubit});

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
                title: "firstName".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (submit) {
                FocusScope.of(context).requestFocus(signUpCubit.lastNameNode);
              },
              hintText: "enterFirstName".tr(),
              focusNode: signUpCubit.firstNameNode,
              controller: signUpCubit.firstNameController,
              keyboardType: TextInputType.name,
              validator: (name) => MyValidators.displayNameValidator(name),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 200.w,
          child: CustomTextFormField(
            textFieldModel: TextFieldModel(
              customTextLabel: CustomText(
                title: "lastName".tr(),
                textStyle: GoogleFonts.inter(
                  fontSize: 16.sp,
                  color: AppColors.aiModelColor,
                  fontWeight: FontWeight.w300,
                ),
              ),
              onFieldSubmitted: (submit) {
                FocusScope.of(context).requestFocus(signUpCubit.emailNode);
              },
              hintText: "enterLastName".tr(),
              controller: signUpCubit.lastNameController,
              focusNode: signUpCubit.lastNameNode,
              keyboardType: TextInputType.name,
              validator: (name) => MyValidators.displayNameValidator(name),
            ),
          ),
        ),
      ],
    );
  }
}
