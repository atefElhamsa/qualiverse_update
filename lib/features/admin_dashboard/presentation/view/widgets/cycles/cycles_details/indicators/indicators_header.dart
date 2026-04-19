import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class IndicatorsHeader extends StatelessWidget {
  const IndicatorsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20.h),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFECF0F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              title: 'Indicators Name',
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
              title: 'Description',
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'Assigned Doctor',
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'Dead line',
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'Status',
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'Action',
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
        ],
      ),
    );
  }
}
