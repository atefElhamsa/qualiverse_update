import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CoursesHeader extends StatelessWidget {
  const CoursesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(top: 20.h),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: const BoxDecoration(
        color: Color(0xFFECF0F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
      ),
      child: Row(
        children: [
          _cell(context, 'courseName'.tr(), flex: 2),
          _cell(context, 'courseCode'.tr()),
          _cell(context, 'dept'.tr(), centered: true),
          _cell(context, 'level'.tr(), centered: true),
          _cell(context, 'semester'.tr(), centered: true),
          _cell(context, 'assignedDoctor'.tr(), centered: true, flex: 2),
          _cell(context, 'action'.tr(), centered: true),
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
