import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class CyclesHeader extends StatelessWidget {
  const CyclesHeader({super.key});

  static const headerStyle = TextStyle(fontWeight: FontWeight.w600);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: const Color(0xFFECF0F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(title: 'year'.tr(), textStyle: headerStyle),
          ),
          CustomText(
            title: 'action'.tr(),
            textAlign: TextAlign.center,
            textStyle: headerStyle,
          ),
        ],
      ),
    );
  }
}
