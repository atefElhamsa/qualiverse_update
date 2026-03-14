import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
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
          if (state is ResetPasswordOtpSuccess) {
            showSnackBar(context, state.message, AppColors.green);
            context.pop();
          }
        },
        builder: (context, state) {
          final resetPasswordCubit = ResetPasswordCubit.of(context);
          return Padding(
            padding: const EdgeInsets.only(top: 38.0),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const ResetAndDescriptionTextWidget(),
                  const SizedBox(height: 70),
                  Row(
                    children: [
                      EmailFieldWidget(resetPasswordCubit: resetPasswordCubit),
                      const SizedBox(width: 20),
                      state is ResetPasswordLoading
                          ? const CustomLoading()
                          : TextButton(
                              onPressed: () {
                                resetPasswordCubit.forgetPasswordCubit();
                              },
                              child: CustomText(
                                title: "Send OTP",
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .headlineLarge!
                                    .copyWith(fontSize: 14.sp),
                              ),
                            ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  OtpFieldWidget(resetPasswordCubit: resetPasswordCubit),
                  const SizedBox(height: 30),
                  PasswordFieldWidget(resetPasswordCubit: resetPasswordCubit),
                  const SizedBox(height: 30),
                  SendButtonWidget(
                    resetPasswordCubit: resetPasswordCubit,
                    resetPasswordState: state,
                  ),
                  const SizedBox(height: 40),
                  const BackLoginWidget(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
