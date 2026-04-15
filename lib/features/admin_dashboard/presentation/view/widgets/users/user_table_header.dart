import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UserTableHeader extends StatelessWidget {
  const UserTableHeader({super.key});

  static const headerStyle = TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: AppColors.headerBgColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(title: 'name'.tr(), textStyle: headerStyle),
          ),
          Expanded(
            child: CustomText(
              title: 'email'.tr(),
              textStyle: headerStyle,
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'role'.tr(),
              textAlign: TextAlign.center,
              textStyle: headerStyle,
            ),
          ),
          Expanded(
            child: CustomText(
              title: 'status'.tr(),
              textAlign: TextAlign.center,
              textStyle: headerStyle,
            ),
          ),
        ],
      ),
    );
  }
}
