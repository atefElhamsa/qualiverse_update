import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

Widget buildRow(
  BuildContext context,
  CycleIndicatorModel cycleIndicator,
  Color statusColor,
) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    child: Row(
      children: [
        cell(context, cycleIndicator.indicatorName, flex: 1),
        cell(context, cycleIndicator.description, flex: 2, centered: true),
        cell(context, cycleIndicator.doctorName ?? '---', centered: true),
        cell(
          context,
          cycleIndicator.deadline != null
              ? DateFormat('dd-MM-yyyy').format(cycleIndicator.deadline!)
              : '---',
          centered: true,
        ),
        Expanded(
          child: statusBadge(context, cycleIndicator.status, statusColor),
        ),
        Expanded(
          flex: 2,
          child: actions(context, cycleIndicator),
        ),
      ],
    ),
  );
}

Widget buildCard(
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
              statusBadge(context, cycleIndicator.status, statusColor),
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

          actions(context, cycleIndicator),
        ],
      ),
    ),
  );
}

Widget cell(
  BuildContext context,
  String text, {
  int flex = 1,
  bool centered = false,
}) {
  return Expanded(
    flex: flex,
    child: CustomText(
      title: text,
      textAlign: centered ? TextAlign.center : TextAlign.start,
      textStyle: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(fontSize: 13.sp),
    ),
  );
}

Widget statusBadge(BuildContext context, String? status, Color? statusColor) {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 8),
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10.r),
      color: statusColor,
    ),
    child: CustomText(
      title: status?.toLowerCase().tr() ?? '---',
      textAlign: TextAlign.center,
      textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
            fontSize: 13.sp,
            color: AppColors.white,
            fontWeight: FontWeight.w800,
          ),
    ),
  );
}

Widget actions(BuildContext context, CycleIndicatorModel cycleIndicator) {
  final bool isAssigned = cycleIndicator.doctorId != null;
  final bool isSubmitted = cycleIndicator.status?.toLowerCase() == "submitted";

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        child: CustomButton(
          buttonModel: ButtonModel(
            onPressed: () {
              showAssignDialog(context, cycleIndicator);
            },
            backgroundColor: isAssigned ? AppColors.blue : AppColors.green,
            radius: 10,
            customText: CustomText(
              title: isAssigned ? "reassign".tr() : "assign".tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(
                context,
              ).textTheme.titleMedium!.copyWith(
                fontSize: 12.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
      if (isAssigned && !isSubmitted) ...[
        SizedBox(width: 5.w),
        actionIcon(
          icon: Icons.close,
          color: AppColors.grey.withOpacity(0.8),
          onTap: () => showRemoveAssignIndicatorDialog(
            context: context,
            cycleIndicator: cycleIndicator,
          ),
          tooltip: "removeAssign".tr(),
        ),
      ],
      if (!isSubmitted) ...[
        SizedBox(width: 5.w),
        actionIcon(
          icon: Icons.delete_outline,
          color: AppColors.red,
          onTap: () => showDeleteIndicatorDialog(
            context: context,
            cycleIndicator: cycleIndicator,
          ),
          tooltip: "deleteIndicator".tr(),
        ),
      ],
    ],
  );
}

Widget actionIcon({
  required IconData icon,
  required Color color,
  required VoidCallback onTap,
  required String tooltip,
}) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      onTap: onTap,
      child: Tooltip(
        message: tooltip,
        child: Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Icon(icon, color: AppColors.white, size: 16.sp),
        ),
      ),
    ),
  );
}
