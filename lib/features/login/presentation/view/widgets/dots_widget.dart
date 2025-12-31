import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class DotsWidget extends StatelessWidget {
  const DotsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PositionedDirectional(
      top: 38.h,
      start: 87.w,
      child: Image.asset(AppImages.dotsImage, width: 142.w, height: 142.h),
    );
  }
}
