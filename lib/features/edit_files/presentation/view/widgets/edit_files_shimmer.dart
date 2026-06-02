import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EditFilesShimmer extends StatelessWidget {
  final int itemCount;
  const EditFilesShimmer({super.key, this.itemCount = 6});

  @override
  Widget build(BuildContext context) {
    return ContainerWidget(
      widget: LayoutBuilder(
        builder: (context, constraints) {
          final itemWidth = (constraints.maxWidth - 10.w) / 2;
          return Wrap(
            spacing: 10.w,
            runSpacing: 10.h,
            children: List.generate(
              itemCount,
              (index) => SizedBox(
                width: itemWidth,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
                  constraints: BoxConstraints(minHeight: 56.h),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(25.r),
                  ),
                  child: Row(
                    children: [
                      CustomShimmer.rectangular(
                        width: 38.w,
                        height: 38.h,
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      SizedBox(width: 16.w),
                      Expanded(
                        child: CustomShimmer.rectangular(
                          height: 14.h,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
