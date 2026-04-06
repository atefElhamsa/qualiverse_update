import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

TableRow tableHeader(BuildContext context) {
  return TableRow(
    decoration: BoxDecoration(
      color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? AppColors.tableColor
          : AppColors.mainBlack,
    ),
    children: [
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomText(
          title: "indicator".tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 25.sp,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomText(
          title: "uploadFile".tr(),
          textAlign: TextAlign.center,
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 25.sp,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomText(
          title: "uploadedFiles".tr(),
          textAlign: TextAlign.center,
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 25.sp,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
        ),
      ),
    ],
  );
}
