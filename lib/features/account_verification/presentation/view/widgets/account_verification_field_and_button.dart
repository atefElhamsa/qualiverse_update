import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountVerificationFieldAndButton extends StatelessWidget {
  const AccountVerificationFieldAndButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AccountVerificationCubit, AccountVerificationState>(
      listener: (context, state) {
        if (state is AccountVerificationSuccess) {
          showSnackBar(
            context,
            "verification_email_sent".tr(),
            AppColors.green,
          );
          context.pop();
        }
        if (state is AccountVerificationFailure) {
          showSnackBar(context, state.errorMessage, AppColors.red);
        }
      },
      builder: (context, state) {
        return BuilderWithApi(state: state);
      },
    );
  }
}
