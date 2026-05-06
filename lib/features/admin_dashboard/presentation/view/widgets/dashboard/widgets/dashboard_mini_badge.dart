import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class DashboardMiniBadge extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final int total;

  const DashboardMiniBadge({
    super.key,
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final double percent = total > 0 ? (int.parse(value) / total) * 100 : 0;
    return Tooltip(
      message: "$label: $value (${percent.toStringAsFixed(1)}%)",
      preferBelow: false,
      verticalOffset: 20.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      textStyle: TextStyle(
        color: AppColors.mainBlack,
        fontSize: 12.sp,
        fontWeight: FontWeight.w600,
      ),
      child: Container(
        width: 55.w,
        padding: EdgeInsets.symmetric(vertical: 4.h),
        decoration: BoxDecoration(
          color: color.withOpacity(0.12),
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: color.withOpacity(0.3), width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 12.sp),
            SizedBox(width: 4.w),
            CustomText(
              title: value,
              textStyle: TextStyle(
                fontSize: 11.sp,
                color: color,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
