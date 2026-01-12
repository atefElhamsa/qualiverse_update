import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                ),
              ),
              hintText: textFieldModel.hintText,
              label: textFieldModel.customTextLabel,
            ),
          );
        },
      ),
    );
  }
}
