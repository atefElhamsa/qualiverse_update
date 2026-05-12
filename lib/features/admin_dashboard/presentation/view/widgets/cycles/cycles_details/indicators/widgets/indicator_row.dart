import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

Widget indicatorRow(
  BuildContext context,
  CycleIndicatorModel cycleIndicator,
  Color statusColor,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Row(
      children: [
        _cell(context, cycleIndicator.indicatorName, flex: 1),
        _cell(context, cycleIndicator.description, flex: 2, centered: true),
        _cell(context, cycleIndicator.doctorName ?? '---', centered: true),
        _cell(context, cycleIndicator.deadline != null ? DateFormat('dd-MM-yyyy').format(cycleIndicator.deadline!) : '---', centered: true),
        Expanded(child: indicatorStatusBadge(context, cycleIndicator.status, statusColor)),
        Expanded(flex: 2, child: indicatorActions(context, cycleIndicator)),
      ],
    ),
  );
}

Widget _cell(BuildContext context, String text, {int flex = 1, bool centered = false}) {
  return Expanded(
    flex: flex,
    child: CustomText(
      title: text,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(fontSize: 13.sp),
    ),
  );
}
