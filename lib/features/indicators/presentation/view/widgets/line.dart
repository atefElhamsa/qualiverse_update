import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class Line extends StatelessWidget {
  const Line({super.key, required this.indicatorsLength});
  final int indicatorsLength;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: AppColors.grey,
      minHeight: 10,
      value: 1 / indicatorsLength,
      backgroundColor: AppColors.grey,
      borderRadius: BorderRadius.circular(7.5.r),
      stopIndicatorColor: AppColors.green,
      valueColor: const AlwaysStoppedAnimation(Colors.green),
    );
  }
}
