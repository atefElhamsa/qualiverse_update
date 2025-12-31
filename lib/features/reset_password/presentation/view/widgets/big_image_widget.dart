import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class BigImageWidget extends StatelessWidget {
  const BigImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: 450.w,
        height: 600.h,
        alignment: Alignment.bottomCenter,
        child: Image.asset(
          AppImages.bigImageForgetPassword,
          fit: BoxFit.cover,
          height: 500.h,
        ),
      ),
    );
  }
}
