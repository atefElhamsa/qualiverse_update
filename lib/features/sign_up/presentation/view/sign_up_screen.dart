import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? AppColors.loginBackground2
          : AppColors.mainBlack,
      body: const SignUpBody(),
    );
  }
}
