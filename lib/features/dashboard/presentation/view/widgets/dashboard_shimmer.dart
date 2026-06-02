import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'dashboard_top_and_title.dart';

class DashboardShimmer extends StatelessWidget {
  const DashboardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const DashboardTopAndTitle(),
          
          // Tabs Shimmer
          GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 2.8,
            ),
            itemBuilder: (context, index) {
              return CustomShimmer.rectangular(
                height: 87.h,
                borderRadius: BorderRadius.circular(10.r),
              );
            },
          ),
          
          const SizedBox(height: 24),
          
          // Body (EvidenceOverviewContent Shimmer)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Wrap(
                    alignment: WrapAlignment.spaceBetween,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    runSpacing: 30.h,
                    children: [
                      // Left Status Distribution Pie Chart Block
                      ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 640),
                        child: CustomShimmer.rectangular(
                          height: 330.h,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      
                      // Middle Filter Dropdowns Column
                      SizedBox(
                        width: 280.w,
                        child: Column(
                          children: [
                            CustomShimmer.rectangular(
                              height: 56.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            SizedBox(height: 25.h),
                            CustomShimmer.rectangular(
                              height: 56.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            SizedBox(height: 25.h),
                            CustomShimmer.rectangular(
                              height: 56.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            SizedBox(height: 25.h),
                            CustomShimmer.rectangular(
                              height: 56.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ],
                        ),
                      ),
                      
                      // Right Stat Cards Column
                      SizedBox(
                        width: 220.w,
                        child: Column(
                          children: [
                            CustomShimmer.rectangular(
                              height: 90.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            SizedBox(height: 20.h),
                            CustomShimmer.rectangular(
                              height: 90.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            SizedBox(height: 20.h),
                            CustomShimmer.rectangular(
                              height: 90.h,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                
                const SizedBox(height: 24),
                
                // Bottom Evidence Per Criterion Chart Block
                CustomShimmer.rectangular(
                  width: double.infinity,
                  height: 280.h,
                  borderRadius: BorderRadius.circular(8.r),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
