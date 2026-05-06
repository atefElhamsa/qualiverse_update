import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

import 'package:flutter_animate/flutter_animate.dart';

class BaseDashboardCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  const BaseDashboardCard({super.key, required this.child, this.padding});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding ?? EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }
}

class DashboardViewAllRow extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  const DashboardViewAllRow({
    super.key,
    required this.onTap,
    this.title = "viewAll",
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomText(
            title: title.tr(),
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              color: AppColors.blue,
              fontWeight: FontWeight.w700,
              fontSize: 12.sp,
            ),
          ),
          Icon(Icons.arrow_forward_ios, size: 10.sp, color: AppColors.blue),
        ],
      ),
    );
  }
}
