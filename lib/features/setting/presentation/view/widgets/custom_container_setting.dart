import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class CustomContainerSetting extends StatelessWidget {
  const CustomContainerSetting({super.key, required this.widget});
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: AppColors.customContainerSettingColor,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: widget,
    );
  }
}
