import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ResetRightPartWidget extends StatelessWidget {
  const ResetRightPartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listener: (context, state) {
          if (state is ResetPasswordFailure) {
            showSnackBar(context, state.errorMessage, AppColors.red);
          }
          if (state is ResetPasswordSuccess) {
            showSnackBar(context, state.message, AppColors.green);
          }
        },
        builder: (context, state) {
          final forgetPasswordCubit = ResetPasswordCubit.of(context);
          return state is ResetPasswordLoading
              ? const CustomLoading()
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ResetAndDescriptionTextWidget(),
                      const SizedBox(height: 70),
                      EmailFieldWidget(resetPasswordCubit: forgetPasswordCubit),
                      const SizedBox(height: 50),
                      SendButtonWidget(resetPasswordCubit: forgetPasswordCubit),
                      const SizedBox(height: 63),
                      const BackLoginWidget(),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
