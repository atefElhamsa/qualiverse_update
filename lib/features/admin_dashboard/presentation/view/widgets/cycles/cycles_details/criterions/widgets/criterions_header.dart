import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CriterionsHeader extends StatelessWidget {
  const CriterionsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFECF0F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          _cell(context, 'criterionName'.tr(), flex: 2),
          _cell(context, 'accreditation'.tr(), centered: true),
          _cell(context, 'department'.tr(), centered: true),
          _cell(context, 'indicatorsCount'.tr(), centered: true),
          _cell(context, 'status'.tr(), centered: true),
          _cell(context, 'actions'.tr(), centered: true),
        ],
      ),
    );
  }

  Widget _cell(BuildContext context, String title, {int flex = 1, bool centered = false}) {
    return Expanded(
      flex: flex,
      child: CustomText(
        title: title,
        textAlign: centered ? TextAlign.center : TextAlign.start,
        textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
      ),
    );
  }
}
