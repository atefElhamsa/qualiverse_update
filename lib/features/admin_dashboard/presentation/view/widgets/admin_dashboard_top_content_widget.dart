import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class AdminDashboardTopContentWidget extends StatelessWidget {
  const AdminDashboardTopContentWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 50.w, top: 100.h, end: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomText(
              title: "adminPanel".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 24.sp),
            ),
          ),
          const SizedBox(height: 20),
          CustomText(
            title: title.tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 32.sp),
          ),
        ],
      ),
    );
  }
}
