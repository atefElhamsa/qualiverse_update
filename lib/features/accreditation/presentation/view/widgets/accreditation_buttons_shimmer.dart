import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/shared_widgets/custom_shimmer.dart';

class AccreditationButtonsShimmer extends StatelessWidget {
  const AccreditationButtonsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FittedBox(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Program Button Shimmer Column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomShimmer.rectangular(
                  height: 80.h,
                  width: 198.w,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                SizedBox(height: 20.h),
                CustomShimmer.circular(size: 84.w),
              ],
            ),
            const SizedBox(width: 90),
            // Institutional Button Shimmer Column
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomShimmer.rectangular(
                  height: 80.h,
                  width: 248.w,
                  borderRadius: BorderRadius.circular(20.r),
                ),
                SizedBox(height: 20.h),
                CustomShimmer.circular(size: 84.w),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
