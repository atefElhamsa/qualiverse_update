import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SecondTermTopAndTitle extends StatelessWidget {
  const SecondTermTopAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 250.h,
      child: Stack(
        children: [
          const FirstTermTop(),
          Positioned(
            top: 160.h,
            left: 0,
            right: 0,
            child: Center(
              child: CustomText(
                title: "secondTerm".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 50.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
