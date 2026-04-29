import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

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
              title: 'indicatorsName'.tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
              title: 'description'.tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'assignedDoctor'.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'deadline'.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'status'.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          Expanded(
            flex: 2,
            child: CustomText(
              title: 'action'.tr(),
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
