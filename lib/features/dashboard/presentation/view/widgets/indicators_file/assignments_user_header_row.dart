import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:easy_localization/easy_localization.dart';

const kAssignmentsFlex = [3, 5, 3, 2, 2, 1];
List<String> getAssignmentsHeaders() => [
  'indicator'.tr(),
  'description'.tr(),
  'deadline'.tr(),
  'status'.tr(),
  'daysRemaining'.tr(),
  'action'.tr(),
];

class AssignmentsUserHeaderRow extends StatelessWidget {
  const AssignmentsUserHeaderRow({super.key});

  @override
  Widget build(BuildContext context) {
    final headers = getAssignmentsHeaders();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.tableColor
            : AppColors.mainBlack,
        borderRadius: BorderRadius.circular(12.r),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
      child: Row(
        children: List.generate(
          headers.length,
          (i) => Expanded(
            flex: kAssignmentsFlex[i],
            child: Text(
              headers[i],
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontWeight: FontWeight.w700,
                fontSize: 15.sp,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
