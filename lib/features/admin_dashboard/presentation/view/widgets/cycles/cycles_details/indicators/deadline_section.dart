import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class DeadlineSection extends StatelessWidget {
  const DeadlineSection({
    super.key,
    required this.selectedDeadline,
    required this.onTap,
  });

  final DateTime? selectedDeadline;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel(title: 'Deadline'),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.grey),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: selectedDeadline != null
                      ? DateFormat('d-MM-yyyy').format(selectedDeadline!)
                      : 'Select Deadline',
                  textStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium!.copyWith(fontSize: 14.sp),
                ),
                const MouseRegion(
                  cursor: SystemMouseCursors.click,
                  child: Icon(Icons.calendar_month, color: AppColors.blue),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
