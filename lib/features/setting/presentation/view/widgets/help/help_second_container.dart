import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class HelpSecondContainer extends StatelessWidget {
  const HelpSecondContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomContainerSetting(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            title: "contactSupport".tr(),
            textStyle: Theme.of(context).textTheme.titleSmall!,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: CustomText(
              title: "contactSupportMessage".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          CustomText(
            title: "supportEmail".tr(),
            textStyle: Theme.of(context).textTheme.titleSmall!,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: CustomText(
              title: "support@aqs-system.edu",
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          CustomText(
            title: "phoneWhatsapp".tr(),
            textStyle: Theme.of(context).textTheme.titleSmall!,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: CustomText(
              title: "+20 100 000 0000",
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
          CustomText(
            title: "supportForm".tr(),
            textStyle: Theme.of(context).textTheme.titleSmall!,
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 10),
            child: CustomText(
              title: "https://workspace.google.com/products/forms/",
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
