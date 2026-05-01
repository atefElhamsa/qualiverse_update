import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';

Widget indicatorStatusBadge(BuildContext context, String? status, Color? statusColor) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: statusColor,
    ),
    child: CustomText(
      title: status ?? '---',
      textAlign: TextAlign.center,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13.sp),
    ),
  );
}
