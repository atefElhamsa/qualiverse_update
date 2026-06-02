import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';

class CoursesShimmer extends StatelessWidget {
  const CoursesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: 1.7,
      ),
      itemCount: 8,
      itemBuilder: (context, index) {
        return SizedBox(
          width: 218.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              CustomShimmer.rectangular(
                height: 97.h,
                width: 218.w,
                borderRadius: BorderRadius.circular(20.r),
              ),
              const SizedBox(height: 5),
              CustomShimmer.rectangular(
                height: 14.h,
                width: 140.w,
                borderRadius: BorderRadius.circular(6.r),
              ),
            ],
          ),
        );
      },
    );
  }
}
