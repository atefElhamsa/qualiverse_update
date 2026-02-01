import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SignUpFieldsAndButton extends StatelessWidget {
  const SignUpFieldsAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listener: (context, state) {
          if (state is SignUpFailure) {
            showSnackBar(context, state.errorMessage, AppColors.red);
          }
          if (state is SignUpSuccess) {
            showSnackBar(context, state.message, AppColors.green);
            context.pop();
          }
        },
        builder: (context, state) {
          final signUpCubit = SignUpCubit.of(context);
          return Padding(
            padding: EdgeInsetsDirectional.only(top: 50.h, start: 51.w),
            child: Column(
              crossAxisAlignment: signUpCubit.state is SignUpLoading
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              children: [
                FirstAndLastNameFields(signUpCubit: signUpCubit),
                const SizedBox(height: 25),
                EmailAndPasswordAndConfirmPasswordFields(
                  signUpCubit: signUpCubit,
                ),
                const SizedBox(height: 25),
                SignUpButton(signUpCubit: signUpCubit),
              ],
            ),
          );
        },
      ),
    );
  }
}
