import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CriterionsTableShimmer extends StatelessWidget {
  const CriterionsTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CriterionsHeader(),
        ...List.generate(3, (index) {
          return Container(
            decoration: const BoxDecoration(
              color: AppColors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                left: BorderSide(color: Color(0xFFE5E7EB), width: 1),
                right: BorderSide(color: Color(0xFFE5E7EB), width: 1),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  // Criterion Name
                  Expanded(
                    flex: 2,
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomShimmer.rectangular(
                        height: 26.h,
                        width: 140.w,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Accreditation
                  Expanded(
                    child: Center(
                      child: CustomShimmer.rectangular(
                        height: 26.h,
                        width: 80.w,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Department
                  Expanded(
                    child: Center(
                      child: CustomShimmer.rectangular(
                        height: 14.h,
                        width: 40.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Indicators Count
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomShimmer.rectangular(
                          height: 14.h,
                          width: 20.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                        SizedBox(width: 12.w),
                        CustomShimmer.rectangular(
                          height: 24.w,
                          width: 24.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Status
                  Expanded(
                    child: Center(
                      child: CustomShimmer.rectangular(
                        height: 26.h,
                        width: 70.w,
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  // Actions (Switch)
                  Expanded(
                    child: Center(
                      child: CustomShimmer.rectangular(
                        height: 24.h,
                        width: 40.w,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ],
    );
  }
}
