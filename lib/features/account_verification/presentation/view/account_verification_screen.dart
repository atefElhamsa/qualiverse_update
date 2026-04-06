import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountVerificationScreen extends StatelessWidget {
  const AccountVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? AppColors.loginBackground2
          : AppColors.mainBlack,
      body: BlocProvider(
        create: (context) => AccountVerificationCubit(),
        child: const AccountVerificationBody(),
      ),
    );
  }
}
