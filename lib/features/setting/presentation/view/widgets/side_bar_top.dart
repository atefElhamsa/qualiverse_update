import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SideBarTop extends StatelessWidget {
  const SideBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    return Padding(
      padding: EdgeInsets.only(
        left: locale == const Locale('ar') ? 0 : 27.w,
        right: locale == const Locale('ar') ? 0 : 27.w,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50.r,
            backgroundImage: const AssetImage(AppImages.logo),
            backgroundColor: AppColors.transparent,
          ),
          const SizedBox(height: 10),
          CustomText(
            title: "accreditationQualitySystem".tr(),
            textStyle: Theme.of(context).textTheme.headlineLarge!,
          ),
          const SizedBox(height: 10),
          CustomDrawer(controller: inherited.controller),
          const SizedBox(height: 25),
          CustomText(
            title: "settings".tr(),
            textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 32.sp,
            ),
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }
}
