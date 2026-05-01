import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UpdateFolderField extends StatelessWidget {
  const UpdateFolderField({super.key, required this.updateFolderCubit});

  final UpdateFolderCubit updateFolderCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: Form(
        key: updateFolderCubit.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomTextFormField(
              textFieldModel: TextFieldModel(
                controller: updateFolderCubit.editFolderNameArController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                hintText: "enterFolderNameArabic".tr(),
                validator: (value) => MyValidators.displayNameValidator(value),
                customTextLabel: CustomText(
                  title: "folderNameArabic".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            CustomTextFormField(
              textFieldModel: TextFieldModel(
                controller: updateFolderCubit.editFolderNameEnController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                hintText: "enterFolderNameEnglish".tr(),
                validator: (value) => MyValidators.displayNameValidator(value),
                customTextLabel: CustomText(
                  title: "folderNameEnglish".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
