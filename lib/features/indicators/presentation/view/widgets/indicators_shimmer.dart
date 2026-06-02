import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';

class IndicatorsShimmer extends StatelessWidget {
  const IndicatorsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Middle Content text skeletons
        CustomShimmer.rectangular(
          height: 24.h,
          width: 300.w,
          borderRadius: BorderRadius.circular(6.r),
        ),
        SizedBox(height: 10.h),
        CustomShimmer.rectangular(
          height: 20.h,
          width: 150.w,
          borderRadius: BorderRadius.circular(6.r),
        ),
        SizedBox(height: 30.h),
        
        // Table Skeleton
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Table(
            border: TableBorder.all(color: Colors.transparent),
            columnWidths: {
              0: FixedColumnWidth(450.w),
              1: FixedColumnWidth(300.w),
              2: FixedColumnWidth(450.w),
            },
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
            children: [
              // Header Skeleton Row
              TableRow(
                children: [
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: CustomShimmer.rectangular(
                        height: 20.h,
                        width: 120.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: CustomShimmer.rectangular(
                        height: 20.h,
                        width: 100.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                  TableCell(
                    child: Padding(
                      padding: EdgeInsets.all(8.w),
                      child: CustomShimmer.rectangular(
                        height: 20.h,
                        width: 120.w,
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                  ),
                ],
              ),
              // Table row spacing
              TableRow(
                children: [
                  SizedBox(height: 15.h),
                  SizedBox(height: 15.h),
                  SizedBox(height: 15.h),
                ],
              ),
              // 4 Skeleton Rows representing indicators
              for (int i = 0; i < 4; i++) ...[
                TableRow(
                  children: [
                    // Column 0: Long text indicator
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: CustomShimmer.rectangular(
                          height: 16.h,
                          width: 380.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                    // Column 1: Action button
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: CustomShimmer.rectangular(
                          height: 40.h,
                          width: 160.w,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                    ),
                    // Column 2: Uploaded files placeholder
                    TableCell(
                      child: Padding(
                        padding: EdgeInsets.all(8.w),
                        child: CustomShimmer.rectangular(
                          height: 16.h,
                          width: 250.w,
                          borderRadius: BorderRadius.circular(4.r),
                        ),
                      ),
                    ),
                  ],
                ),
                // Table row spacing
                TableRow(
                  children: [
                    SizedBox(height: 15.h),
                    SizedBox(height: 15.h),
                    SizedBox(height: 15.h),
                  ],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
