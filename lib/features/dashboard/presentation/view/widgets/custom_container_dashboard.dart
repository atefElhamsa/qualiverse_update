import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CustomContainerDashboard extends StatelessWidget {
  const CustomContainerDashboard({super.key, required this.widget, this.width});

  final Widget widget;
  final int? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: (width ?? 160).w,
      height: 80.h,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: AppColors.grey,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            color: AppColors.sideBarTextDark.withValues(alpha: 0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: widget,
    );
  }
}
