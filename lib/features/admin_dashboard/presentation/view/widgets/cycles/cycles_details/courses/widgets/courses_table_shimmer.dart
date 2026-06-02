import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesTableShimmer extends StatelessWidget {
  const CoursesTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CoursesHeader(),
        ...List.generate(3, (index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    // Course Name
                    Expanded(
                      flex: 2,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 140.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Course Code
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 60.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Department
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 60.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Level
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 50.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Semester/Term
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 50.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Doctor
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 100.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Actions
                    Expanded(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomShimmer.circular(size: 24.w),
                          SizedBox(width: 8.w),
                          CustomShimmer.circular(size: 24.w),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (index < 2)
                const Divider(height: 1, thickness: 1, color: AppColors.grey),
            ],
          );
        }),
      ],
    );
  }
}
