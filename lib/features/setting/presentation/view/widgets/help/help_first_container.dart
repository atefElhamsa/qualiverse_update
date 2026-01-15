import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class HelpFirstContainer extends StatelessWidget {
  const HelpFirstContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerSetting(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: "aboutSystem".tr(),
            textStyle: Theme.of(context).textTheme.titleSmall!,
          ),
          SizedBox(height: 10),
          CustomText(
            title: "aboutSystemDescription".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
