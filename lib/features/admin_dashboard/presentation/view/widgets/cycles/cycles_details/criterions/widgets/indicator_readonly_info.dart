import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class IndicatorReadonlyInfo extends StatelessWidget {
  final String label, value;
  const IndicatorReadonlyInfo({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h),
      child: Row(
        children: [
          SizedBox(width: 150.w, child: CustomText(title: label, textStyle: TextStyle(fontSize: 15.sp, color: AppColors.grey, fontWeight: FontWeight.w600))),
          Expanded(child: CustomText(title: value, textStyle: TextStyle(fontSize: 15.sp, color: AppColors.mainBlack, fontWeight: FontWeight.w600))),
        ],
      ),
    );
  }
}
