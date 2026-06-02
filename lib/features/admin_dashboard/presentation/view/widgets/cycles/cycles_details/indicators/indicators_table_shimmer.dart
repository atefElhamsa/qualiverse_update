import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class IndicatorsTableShimmer extends StatelessWidget {
  const IndicatorsTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const IndicatorsHeader(),
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
                    // Indicators Name
                    Expanded(
                      flex: 1,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 80.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Description
                    Expanded(
                      flex: 2,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 160.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Assigned Doctor
                    Expanded(
                      flex: 1,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          width: 70.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Deadline
                    Expanded(
                      flex: 1,
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
                      flex: 1,
                      child: Center(
                        child: CustomShimmer.rectangular(
                          height: 26.h,
                          width: 70.w,
                          borderRadius: BorderRadius.circular(10.r),
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
                            height: 36.h,
                            width: 80.w,
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          SizedBox(width: 5.w),
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
