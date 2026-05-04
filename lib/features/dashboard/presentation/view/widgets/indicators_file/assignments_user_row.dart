import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/dashboard/data/models/assignments_user_model.dart';
import 'assignments_user_header_row.dart';

class AssignmentsUserRow extends StatelessWidget {
  final AssignmentData assignment;
  const AssignmentsUserRow({super.key, required this.assignment});

  @override
  Widget build(BuildContext context) {
    final cells = [
      assignment.indicatorName,
      assignment.description,
      DateFormat('yyyy-MM-dd').format(assignment.deadline),
      assignment.status,
      assignment.daysRemaining.toString(),
    ];

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
            ? AppColors.white
            : AppColors.mainBlack,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Row(
        children: List.generate(getAssignmentsHeaders().length, (i) {
          if (i == 3) {
            return Expanded(
              flex: kAssignmentsFlex[i],
              child: _buildStatusBadge(assignment.status),
            );
          }
          if (i == 5) {
            return Expanded(
              flex: kAssignmentsFlex[i],
              child: Center(
                child: Icon(
                  Icons.visibility_outlined,
                  color: AppColors.viewAndDeleteIconColor,
                  size: 20.sp,
                ),
              ),
            );
          }
          return Expanded(
            flex: kAssignmentsFlex[i],
            child: Text(
              cells[i],
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: Theme.of(context).colorScheme.onSecondary,
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildStatusBadge(String status) {
    Color color;
    String labelKey = status.toLowerCase();

    switch (status) {
      case 'Approved':
        color = const Color(0xFF10B981); // أخضر غامق واحترافي
        break;
      case 'Pending':
        color = const Color(0xFFF59E0B); // برتقالي غامق
        break;
      case 'Submitted':
        color = const Color(0xFF3B82F6); // أزرق صريح للمراجعة
        break;
      case 'Rejected':
        color = const Color(0xFFEF4444); // أحمر صريح
        break;
      default:
        color = AppColors.grey;
    }

    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(6.r),
        ),
        child: Text(
          labelKey.tr(),
          style: GoogleFonts.inter(
            color: AppColors.white,
            fontSize: 11.sp,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}
