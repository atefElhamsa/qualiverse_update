import 'package:easy_localization/easy_localization.dart';
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
          PositionedDirectional(
            top: 55.h,
            end: 40.w,
            child: SizedBox(
              width: 180.w,
              height: 55.h,
              child: CustomButton(
                buttonModel: ButtonModel(
                  onPressed: () {},
                  backgroundColor: AppColors.progressColor,
                  radius: 12.r,
                  customText: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.cloud_upload_rounded,
                        color: AppColors.white,
                        size: 24.sp,
                      ),
                      SizedBox(width: 8.w),
                      CustomText(
                        title: "uploadFile".tr(),
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
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
