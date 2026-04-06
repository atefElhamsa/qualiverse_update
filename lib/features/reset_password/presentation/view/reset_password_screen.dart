import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

import '../../reset_password_imports/reset_password_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? AppColors.loginBackground2
          : AppColors.mainBlack,
      body: const ResetPasswordBody(),
    );
  }
}
