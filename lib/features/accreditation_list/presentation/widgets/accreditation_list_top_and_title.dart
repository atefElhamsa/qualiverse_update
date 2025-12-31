import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AccreditationListTopAndTitle extends StatelessWidget {
  const AccreditationListTopAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 320.h,
      child: Stack(
        children: [
          const AccreditationListTop(),
          Positioned(
            top: 160.h,
            left: 0,
            right: 0,
            child: Column(
              children: [
                CustomText(
                  title: AppTexts.indicatorsPages,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.displayLarge!.copyWith(fontSize: 50.sp),
                ),
                const SizedBox(height: 10),
                CustomText(
                  title: AppTexts.institutionalAccreditation,
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
