import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class SideBarTop extends StatelessWidget {
  const SideBarTop({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    final isArabic = locale == const Locale('ar');
    return Padding(
      padding: EdgeInsets.only(
        left: isArabic ? 16.w : 20.w,
        right: isArabic ? 20.w : 16.w,
        top: 20.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 35.r,
            backgroundImage: const AssetImage(AppImages.logo),
            backgroundColor: AppColors.transparent,
          ),
          const SizedBox(height: 12),
          CustomText(
            title: "accreditationQualitySystem".tr(),
            textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 16),
          CustomDrawerAndBackWidget(controller: inherited.controller),
          const SizedBox(height: 20),
          CustomText(
            title: "settings".tr(),
            textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
              fontWeight: FontWeight.w800,
              fontSize: 28.sp,
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
