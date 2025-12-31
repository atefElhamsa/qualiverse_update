import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AccreditationDefinition extends StatelessWidget {
  const AccreditationDefinition({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 800;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: isSmallScreen
              ? const BuildColumnLayout()
              : const BuildRowLayout(),
        );
      },
    );
  }
}
