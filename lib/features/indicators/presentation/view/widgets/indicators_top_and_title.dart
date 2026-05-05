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
