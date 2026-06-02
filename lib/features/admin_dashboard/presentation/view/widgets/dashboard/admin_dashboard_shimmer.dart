import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';

class AdminDashboardShimmer extends StatelessWidget {
  const AdminDashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10.h),
          
          // 4 Top Summary Cards Shimmer
          Row(
            children: [
              Expanded(
                child: CustomShimmer.rectangular(
                  height: 140.h,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomShimmer.rectangular(
                  height: 140.h,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomShimmer.rectangular(
                  height: 140.h,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomShimmer.rectangular(
                  height: 140.h,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            ],
          ),
          
          SizedBox(height: 24.h),
          
          // Department Bar Chart Shimmer
          CustomShimmer.rectangular(
            width: double.infinity,
            height: 320.h,
            borderRadius: BorderRadius.circular(16.r),
          ),
          
          SizedBox(height: 24.h),
          
          // Institutional Progress Card Shimmer
          CustomShimmer.rectangular(
            width: double.infinity,
            height: 180.h,
            borderRadius: BorderRadius.circular(16.r),
          ),
          
          SizedBox(height: 40.h),
        ],
      ),
    );
  }
}
