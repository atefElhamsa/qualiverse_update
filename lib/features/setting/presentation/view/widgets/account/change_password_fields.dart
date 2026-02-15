import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class ChangePasswordFields extends StatelessWidget {
  const ChangePasswordFields({super.key, required this.changePasswordCubit});

  final ChangePasswordCubit changePasswordCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        spacing: 25.h,
        children: [
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: changePasswordCubit.currentPasswordController,
              focusNode: changePasswordCubit.currentPasswordNode,
              hintText: "enterYourCurrentPassword".tr(),
              isObscured: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (password) => MyValidators.passwordValidator(password),
              onFieldSubmitted: (submit) {
                FocusScope.of(
                  context,
                ).requestFocus(changePasswordCubit.newPasswordNode);
              },
              customTextLabel: CustomText(
                title: "currentPassword".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
              ),
            ),
          ),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: changePasswordCubit.newPasswordController,
              focusNode: changePasswordCubit.newPasswordNode,
              onFieldSubmitted: (submit) {
                FocusScope.of(
                  context,
                ).requestFocus(changePasswordCubit.confirmPasswordNode);
              },
              hintText: "enterYourNewPassword".tr(),
              isObscured: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (newPassword) =>
                  MyValidators.passwordValidator(newPassword),
              customTextLabel: CustomText(
                title: "newPassword".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
              ),
            ),
          ),
          CustomTextFormField(
            textFieldModel: TextFieldModel(
              controller: changePasswordCubit.confirmPasswordController,
              focusNode: changePasswordCubit.confirmPasswordNode,
              onFieldSubmitted: (submit) {
                changePasswordCubit.changePasswordCubit();
              },
              hintText: "reEnterYourNewPassword".tr(),
              isObscured: true,
              keyboardType: TextInputType.visiblePassword,
              validator: (confirmNewPassword) =>
                  MyValidators.repeatPasswordValidator(
                    value: confirmNewPassword?.trim(),
                    password: changePasswordCubit.newPasswordController.text
                        .trim(),
                  ),
              customTextLabel: CustomText(
                title: "confirmNewPassword".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
