import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.textFieldModel});

  final TextFieldModel textFieldModel;

  @override
  Widget build(BuildContext context) {
    final isPasswordField = textFieldModel.isObscured == true;

    return BlocProvider(
      create: (_) => PasswordCubit(isPasswordField),
      child: BlocBuilder<PasswordCubit, bool>(
        builder: (context, isObscured) {
          return TextFormField(
            controller: textFieldModel.controller,
            onTap: textFieldModel.onTap,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: textFieldModel.keyboardType,
            obscureText: isPasswordField ? isObscured : false,
            enableInteractiveSelection: true,
            toolbarOptions: const ToolbarOptions(
              copy: true,
              cut: true,
              paste: true,
              selectAll: true,
            ),
            validator: textFieldModel.validator,
            focusNode: textFieldModel.focusNode,
            onFieldSubmitted: textFieldModel.onFieldSubmitted,
            decoration: InputDecoration(
              fillColor: AppColors.transparent,
              filled: true,
              suffixIcon: GestureDetector(
                onTap: () {
                  if (isPasswordField) {
                    context.read<PasswordCubit>().toggle();
                  } else {
                    textFieldModel.controller.clear();
                  }
                },
                child: Icon(
                  isPasswordField
                      ? (isObscured ? Icons.visibility : Icons.visibility_off)
                      : Icons.clear,
                  color: AppColors.greyLight,
                ),
              ),
              hintText: textFieldModel.hintText,
              hintStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 16.sp,
                color: AppColors.greyLight,
              ),
              label: textFieldModel.customTextLabel,
            ),
          );
        },
      ),
    );
  }
}
