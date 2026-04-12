import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class StandardsIndicatorModel {
  final String standard;
  final String indicator;
  final String status;

  const StandardsIndicatorModel({
    required this.standard,
    required this.indicator,
    required this.status,
  });
}

class StandardsIndicatorScreen extends StatelessWidget {
  final List<StandardsIndicatorModel> items;

  const StandardsIndicatorScreen({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(start: 50.w, end: 30.w, bottom: 20.h),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomText(
            title: 'Standards & Indicators',
            textStyle: Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(fontSize: 25.sp),
          ),
          const SizedBox(height: 16),
          BuildTable(items: items),
        ],
      ),
    );
  }
}
