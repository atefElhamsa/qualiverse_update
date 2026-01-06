import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class IndicatorsTopAndTitle extends StatelessWidget {
  const IndicatorsTopAndTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 320.h,
      child: Stack(
        children: [
          const IndicatorsTop(),
          Positioned(
            top: 160.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CustomText(
                  title: "indicatorsPage".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 50.sp),
                ),
                const SizedBox(height: 10),
                CustomText(
                  title: title.tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 35.sp),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
