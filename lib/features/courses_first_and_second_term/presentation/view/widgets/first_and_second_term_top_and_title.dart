import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FirstTermTopAndTitle extends StatelessWidget {
  const FirstTermTopAndTitle({super.key, required this.tile});

  final String tile;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 260.h,
      child: Stack(
        children: [
          const FirstTermTop(),
          Positioned(
            top: 160.h,
            left: 0,
            right: 0,
            child: Center(
              child: CustomText(
                title: tile,
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
