import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AccountVerificationScreen extends StatelessWidget {
  const AccountVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: AppColors.loginBackground2,
      body: AccountVerificationBody(),
    );
  }
}
