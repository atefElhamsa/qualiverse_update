import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class EmptyIndicatorsList extends StatelessWidget {
  const EmptyIndicatorsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.only(top: 50.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.insert_drive_file_outlined,
              size: 64,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            CustomText(
              title: "noIndicatorsTitle".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(fontSize: 20.sp),
            ),
            const SizedBox(height: 8),
            CustomText(
              title: "noIndicatorsDescription".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
