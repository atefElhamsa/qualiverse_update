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
            onTap: textFieldModel.onTap,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            keyboardType: textFieldModel.keyboardType,
            obscureText: isPasswordField ? isObscured : false,
            controller: textFieldModel.controller,
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
                  color: Theme.of(context).inputDecorationTheme.suffixIconColor,
                ),
              ),
              hintText: textFieldModel.hintText,
              label: textFieldModel.customTextLabel,
              hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
              enabledBorder: Theme.of(
                context,
              ).inputDecorationTheme.enabledBorder,
              focusedBorder: Theme.of(
                context,
              ).inputDecorationTheme.focusedBorder,
              errorBorder: Theme.of(context).inputDecorationTheme.errorBorder,
              focusedErrorBorder: Theme.of(
                context,
              ).inputDecorationTheme.focusedErrorBorder,
              errorStyle: Theme.of(context).inputDecorationTheme.errorStyle,
            ),
          );
        },
      ),
    );
  }
}
