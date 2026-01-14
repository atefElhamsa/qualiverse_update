import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class NotificationSettingsContent extends StatelessWidget {
  const NotificationSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 50.w, end: 10.w, top: 70.h),
      child: ListView(
        padding: EdgeInsets.all(10),
        physics: BouncingScrollPhysics(),
        children: [
          CustomText(
            title: "accountNotification".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontSize: 32.sp),
          ),
          SizedBox(height: 10),
          ThemeSelector(),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
