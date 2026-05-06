import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CustomHomeLastWidget extends StatelessWidget {
  const CustomHomeLastWidget({super.key, required this.homeLastBodyModel});

  final HomeLastBodyModel homeLastBodyModel;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: SizedBox(
        width: 250.w,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 65.w,
              height: 65.w,
              child: Image.asset(homeLastBodyModel.image),
            ),
            SizedBox(height: 20.h),
            CustomText(
              title: homeLastBodyModel.title.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.w900,
                    fontSize: 18.sp,
                  ),
            ),
            SizedBox(height: 15.h),
            CustomText(
              title: homeLastBodyModel.description.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 16.sp,
                    height: 1.4,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
