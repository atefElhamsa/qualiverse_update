import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

import '../../reset_password_imports/reset_password_imports.dart';

class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.loginBackground2,
      body: ResetPasswordBody(),
    );
  }
}
