import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';

class CyclesListShimmer extends StatelessWidget {
  const CyclesListShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(2, (index) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: Row(
                children: [
                  // Year number
                  Expanded(
                    child: CustomShimmer.rectangular(
                      height: 14.h,
                      width: 80.w,
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                  // View button
                  CustomShimmer.rectangular(
                    height: 36.h,
                    width: 80.w,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  SizedBox(width: 8.w),
                  // Delete button
                  CustomShimmer.rectangular(
                    height: 36.h,
                    width: 80.w,
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ],
              ),
            ),
            if (index < 3)
              const Divider(height: 1, thickness: 1, color: Color(0xFFEEEEEE)),
          ],
        );
      }),
    );
  }
}
