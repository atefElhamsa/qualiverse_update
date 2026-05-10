import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StepWrapper extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const StepWrapper({
    super.key,
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: const Color(0xFF0D47A1), size: 28.sp),
              SizedBox(width: 15.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0D47A1),
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          child,
        ],
      ),
    );
  }
}
