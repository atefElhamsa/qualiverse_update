import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class DashboardTapsWidget extends StatelessWidget {
  DashboardTapsWidget({super.key});

  final List<String> titles = [
    'evidenceUploaded',
    'completion',
    'activeUsers',
    'openCycles',
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      padding: EdgeInsetsDirectional.only(start: 50.w, end: 30.w),
      physics: const NeverScrollableScrollPhysics(),
      itemCount: titles.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
        childAspectRatio: 2.6,
      ),
      itemBuilder: (context, index) {
        return AnimatedContainer(
          constraints: BoxConstraints(minWidth: 214.w, minHeight: 87.h),
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: AppColors.colorTapAdminDashboard,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomText(
                title: titles[index].tr(),
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: AppColors.blue,
                  fontSize: 18.sp,
                ),
              ),
              CustomText(
                title: "350",
                textAlign: TextAlign.center,
                textStyle: Theme.of(context).textTheme.bodyMedium!,
              ),
            ],
          ),
        );
      },
    );
  }
}
