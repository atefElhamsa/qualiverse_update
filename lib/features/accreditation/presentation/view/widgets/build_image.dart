import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({super.key});

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxWidth: 447.w, maxHeight: 318.h),
      child: Image.asset(AppImages.accreditationImage, fit: BoxFit.contain),
    );
  }
}
