import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        WhiteContainerWidget(),
        SignUpBodyDetails(),
        DotsWidget(),
        CreateAccountTextWidget(),
      ],
    );
  }
}
