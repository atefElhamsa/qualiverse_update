import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';

class DropdownShimmer extends StatelessWidget {
  const DropdownShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 592.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title skeleton
          Padding(
            padding: EdgeInsets.only(left: 8.w, bottom: 6.h),
            child: CustomShimmer.rectangular(
              height: 16.h,
              width: 100.w,
              borderRadius: BorderRadius.circular(4.r),
            ),
          ),
          // Dropdown button skeleton
          CustomShimmer.rectangular(
            height: 55.h,
            width: 592.w,
            borderRadius: BorderRadius.circular(15.r),
          ),
        ],
      ),
    );
  }
}
