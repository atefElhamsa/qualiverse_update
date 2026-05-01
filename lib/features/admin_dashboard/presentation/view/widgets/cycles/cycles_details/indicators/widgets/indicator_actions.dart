import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_button.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';
import 'package:qualiverse/core/shared_widgets_model/button_model.dart';
import 'package:qualiverse/core/utils/app_colors.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/cycle_indicator_model.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/indicators/assign_indicator_dialog.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/indicators/delete_indicator_dialog.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/indicators/remove_assign_indicator_dialog.dart';

Widget indicatorActions(
  BuildContext context,
  CycleIndicatorModel cycleIndicator,
) {
  final bool isAssigned = cycleIndicator.doctorId != null;
  final bool isSubmitted = cycleIndicator.status?.toLowerCase() == "submitted";

  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Flexible(
        child: CustomButton(
          buttonModel: ButtonModel(
            onPressed: () => showAssignDialog(context, cycleIndicator),
            backgroundColor: isAssigned ? AppColors.blue : AppColors.green,
            radius: 10,
            customText: CustomText(
              title: isAssigned ? "reassign".tr() : "assign".tr(),
              textAlign: TextAlign.center,
              textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
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
        indicatorActionIcon(
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
        indicatorActionIcon(
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

Widget indicatorActionIcon({
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
