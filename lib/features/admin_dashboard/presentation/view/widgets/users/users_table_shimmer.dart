import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UsersTableShimmer extends StatelessWidget {
  const UsersTableShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const UserTableHeader(),
          ...List.generate(5, (index) {
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
                      // Name
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomShimmer.rectangular(
                            height: 14.h,
                            width: 130.w,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      // Email
                      Expanded(
                        child: Center(
                          child: CustomShimmer.rectangular(
                            height: 14.h,
                            width: 160.w,
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                      // Role
                      Expanded(
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
                        child: Center(
                          child: CustomShimmer.rectangular(
                            height: 26.h,
                            width: 75.w,
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                      ),
                      // Actions
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomShimmer.circular(size: 22.w),
                            SizedBox(width: 12.w),
                            CustomShimmer.circular(size: 22.w),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                if (index < 4) const Divider(height: 1, color: AppColors.white),
              ],
            );
          }),
        ],
      ),
    );
  }
}
