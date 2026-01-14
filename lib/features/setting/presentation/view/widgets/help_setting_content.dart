import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class HelpSettingsContent extends StatelessWidget {
  const HelpSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 50.w, end: 10.w, top: 70.h),
      child: ListView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        children: [
          CustomText(
            title: "accountSupport".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 32.sp),
          ),
          const SizedBox(height: 30),
          CustomText(
            title: "howCanWeHelpYou".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 40.sp),
          ),
          const SizedBox(height: 30),
          HelpFirstContainer(),
          const SizedBox(height: 15),
          HelpSecondContainer(),
        ],
      ),
    );
  }
}
