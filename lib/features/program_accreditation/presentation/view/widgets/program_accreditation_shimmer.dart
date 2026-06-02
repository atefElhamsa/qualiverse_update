import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_shimmer.dart';

class ProgramAccreditationShimmer extends StatelessWidget {
  const ProgramAccreditationShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final bool isArabic = locale.languageCode == 'ar';

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 30,
        childAspectRatio: 4,
      ),
      itemCount: 6, // Show 6 skeleton cards while loading
      itemBuilder: (context, index) {
        return SizedBox(
          width: 267.w,
          height: 100.h,
          child: Card(
            color: Theme.of(
              context,
            ).colorScheme.onSecondaryFixed.withOpacity(0.5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.r),
            ),
            elevation: 0,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  if (!isArabic) _buildIconSkeleton(),
                  if (!isArabic) SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomShimmer.rectangular(
                          height: 14.h,
                          width: double.infinity,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                        SizedBox(height: 8.h),
                        CustomShimmer.rectangular(
                          height: 10.h,
                          width: 100.w,
                          borderRadius: BorderRadius.circular(6.r),
                        ),
                      ],
                    ),
                  ),
                  if (isArabic) SizedBox(width: 12.w),
                  if (isArabic) _buildIconSkeleton(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildIconSkeleton() {
    return CustomShimmer.rectangular(
      height: 48.h,
      width: 48.w,
      borderRadius: BorderRadius.circular(12.r),
    );
  }
}
