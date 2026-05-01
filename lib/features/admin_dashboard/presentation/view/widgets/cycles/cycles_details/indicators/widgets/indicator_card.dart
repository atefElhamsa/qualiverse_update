import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/cycle_indicator_model.dart';
import 'indicator_status_badge.dart';
import 'indicator_actions.dart';

Widget indicatorCard(
  BuildContext context,
  CycleIndicatorModel cycleIndicator,
  Color statusColor,
) {
  return Card(
    margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
    elevation: 2,
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: CustomText(
                  title: cycleIndicator.indicatorName,
                  textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              indicatorStatusBadge(context, cycleIndicator.status, statusColor),
            ],
          ),
          SizedBox(height: 8.h),
          CustomText(
            title: cycleIndicator.description,
            textStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(fontSize: 12.sp),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              const Icon(Icons.person_outline, size: 16),
              SizedBox(width: 4.w),
              Expanded(
                child: CustomText(
                  title: cycleIndicator.doctorName ?? '---',
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(fontSize: 12.sp),
                ),
              ),
              const Icon(Icons.calendar_today_outlined, size: 16),
              SizedBox(width: 4.w),
              CustomText(
                title: cycleIndicator.deadline != null
                    ? DateFormat('dd-MM-yyyy').format(cycleIndicator.deadline!)
                    : '---',
                textStyle: Theme.of(
                  context,
                ).textTheme.bodySmall!.copyWith(fontSize: 12.sp),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          indicatorActions(context, cycleIndicator),
        ],
      ),
    ),
  );
}
