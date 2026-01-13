import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

void showAddLanguageBottomSheet(BuildContext context) {
  final cubit = SettingCubit.get(context);

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.customContainerSettingColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (_) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: CustomText(
              title: "arabic".tr(),
              textStyle: Theme.of(context).textTheme.bodyLarge!,
            ),
            onTap: () {
              cubit.addPreferredLanguage(
                AppLanguage(code: 'ar', name: 'arabic'),
              );
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: CustomText(
              title: "english_us".tr(),
              textStyle: Theme.of(context).textTheme.bodyLarge!,
            ),
            onTap: () {
              cubit.addPreferredLanguage(
                AppLanguage(code: 'en', name: 'english_us'),
              );
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
