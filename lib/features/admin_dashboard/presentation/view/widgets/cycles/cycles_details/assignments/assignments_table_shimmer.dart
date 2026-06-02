import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentsTableShimmer extends StatelessWidget {
  const AssignmentsTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AssignmentsHeader(),
        ...List.generate(3, (index) {
          return Container(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: index == 2
                    ? BorderSide.none
                    : const BorderSide(color: AppColors.grey),
              ),
            ),
            child: Row(
              children: [
                // Indicators Name
                Expanded(
                  flex: 2,
                  child: Center(
                    child: CustomShimmer.rectangular(
                      height: 14.h,
                      width: 80.w,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                // Description
                Expanded(
                  flex: 4,
                  child: Center(
                    child: CustomShimmer.rectangular(
                      height: 14.h,
                      width: 180.w,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                // Assigned Doctor
                Expanded(
                  flex: 2,
                  child: Center(
                    child: CustomShimmer.rectangular(
                      height: 14.h,
                      width: 80.w,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                // Deadline
                Expanded(
                  flex: 2,
                  child: Center(
                    child: CustomShimmer.rectangular(
                      height: 14.h,
                      width: 80.w,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                // Status
                Expanded(
                  flex: 2,
                  child: Center(
                    child: CustomShimmer.rectangular(
                      height: 26.h,
                      width: 70.w,
                      borderRadius: BorderRadius.circular(6.r),
                    ),
                  ),
                ),
                // File
                Expanded(
                  flex: 1,
                  child: Center(
                    child: CustomShimmer.rectangular(
                      height: 24.h,
                      width: 24.w,
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                ),
                // Action
                Expanded(
                  flex: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomShimmer.rectangular(
                        height: 24.h,
                        width: 24.w,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      SizedBox(width: 8.w),
                      CustomShimmer.rectangular(
                        height: 24.h,
                        width: 24.w,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}
