import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiDescriptionTop extends StatelessWidget {
  const AiDescriptionTop({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return SizedBox(
      width: double.infinity,
      height: 255.h,
      child: Stack(
        children: [
          CustomScaffoldTop(controller: inherited.controller),
          Positioned(
            top: 100.h,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    // Set the title text from AppTexts.
                    title: AppTexts.aiModel,
                    // Apply custom text style from the current theme.
                    textStyle: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 64.sp),
                  ),
                  CustomText(
                    title: "specification".tr(),
                    textStyle: Theme.of(
                      context,
                    ).textTheme.bodyMedium!.copyWith(fontSize: 32.sp),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
