import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class BuildColumnLayout extends StatelessWidget {
  const BuildColumnLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const BuildTextContent(),
        SizedBox(height: 30.h),
        const BuildImage(),
      ],
    );
  }
}
