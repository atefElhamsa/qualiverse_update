import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        WhiteContainerWidget(),
        ResetPasswordBodyDetails(),
        DotsWidget(),
      ],
    );
  }
}
