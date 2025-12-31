import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class LoginTitleRight extends StatelessWidget {
  const LoginTitleRight({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(
            top: 26.h,
            end: locale == const Locale('ar') ? 117.w : 24.w,
            start: locale == const Locale('ar') ? 24.w : 46.w,
          ),
          child: CustomText(
            title: "accreditationQualitySystem".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 12.sp),
          ),
        ),
      ],
    );
  }
}
