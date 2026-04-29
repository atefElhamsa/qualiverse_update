import 'package:flutter/material.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class BuildHeader extends StatelessWidget {
  const BuildHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.headerBgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              title: 'standard'.tr(),
              textStyle: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'indicator'.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'statues'.tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.titleMedium!,
            ),
          ),
        ],
      ),
    );
  }
}
