import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class BuildRowLayout extends StatelessWidget {
  const BuildRowLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Expanded(flex: 3, child: BuildTextContent()),
        SizedBox(width: 40.w),
        const Expanded(flex: 2, child: BuildImage()),
      ],
    );
  }
}
