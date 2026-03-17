import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CreateFolderField extends StatelessWidget {
  const CreateFolderField({super.key, required this.createFolderCubit});

  final CreateFolderCubit createFolderCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400.w,
      child: CustomTextFormField(
        textFieldModel: TextFieldModel(
          controller: createFolderCubit.newFolderNameController,
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
