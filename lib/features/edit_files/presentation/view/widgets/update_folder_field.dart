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
      child: CustomTextFormField(
        textFieldModel: TextFieldModel(
          controller: updateFolderCubit.editFolderNameController,
          keyboardType: TextInputType.name,
          hintText: "enterFolderName".tr(),
          validator: (value) => MyValidators.displayNameValidator(value),
          customTextLabel: CustomText(
            title: "folderName".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
          ),
        ),
      ),
    );
  }
}
