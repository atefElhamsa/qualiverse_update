import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class IndicatorsFileContent extends StatelessWidget {
  const IndicatorsFileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Image.asset(
          AppImages.indicatorsFile,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
