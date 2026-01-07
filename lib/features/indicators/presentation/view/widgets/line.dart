import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class Line extends StatelessWidget {
  const Line({super.key, required this.indicators});
  final List<IndicatorModel> indicators;

  @override
  Widget build(BuildContext context) {
    return LinearProgressIndicator(
      color: AppColors.grey,
      minHeight: 10,
      value:
          indicators.where((element) => element.filePath != null).length /
          indicators.length,
      backgroundColor: AppColors.grey,
      borderRadius: BorderRadius.circular(7.5.r),
      stopIndicatorColor: AppColors.green,
      valueColor: const AlwaysStoppedAnimation(Colors.green),
    );
  }
}
