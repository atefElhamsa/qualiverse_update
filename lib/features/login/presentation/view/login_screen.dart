import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        backgroundColor:
            Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.loginBackground2
            : AppColors.mainBlack,
        body: const LoginBody(),
      ),
    );
  }
}
