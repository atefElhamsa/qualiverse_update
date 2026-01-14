import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class LanguageSettingsContent extends StatelessWidget {
  const LanguageSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 50.w, end: 10.w, top: 70.h),
      child: ListView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        children: [
          CustomText(
            title: "accountLanguage".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 32.sp),
          ),
          Padding(
            padding: EdgeInsets.only(top: 100.h),
            child: CustomText(
              title: "preferredLanguages".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge!,
            ),
          ),
          SizedBox(height: 20),
          ContainerLanguage(),
        ],
      ),
    );
  }
}
