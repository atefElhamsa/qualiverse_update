import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CriterionBadge extends StatelessWidget {
  final String title;
  final Color bgColor, textColor;
  const CriterionBadge({super.key, required this.title, required this.bgColor, required this.textColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(color: bgColor, borderRadius: BorderRadius.circular(15.r)),
      child: CustomText(title: title, textAlign: TextAlign.center, textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13.sp, color: textColor)),
    );
  }
}
