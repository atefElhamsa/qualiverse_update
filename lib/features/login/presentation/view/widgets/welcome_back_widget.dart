import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class WelcomeBackWidget extends StatelessWidget {
  const WelcomeBackWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 46.w, top: 8.h, end: 24.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: "welcomeBack".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 36.sp),
          ),
        ],
      ),
    );
  }
}
