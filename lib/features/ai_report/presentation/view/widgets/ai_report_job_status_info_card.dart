import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_job_status_model.dart';

class AiReportJobStatusInfoCard extends StatelessWidget {
  final AiReportJobStatusData data;
  final bool isAr;

  const AiReportJobStatusInfoCard({
    super.key,
    required this.data,
    required this.isAr,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('yyyy-MM-dd HH:mm');
    String createdStr = data.createdAt;
    String completedStr = data.completedAt;

    try {
      if (createdStr.isNotEmpty) {
        final parsed = DateTime.parse(createdStr);
        createdStr = dateFormatter.format(parsed);
      }
      if (completedStr.isNotEmpty) {
        final parsed = DateTime.parse(completedStr);
        completedStr = dateFormatter.format(parsed);
      }
    } catch (_) {}

    return Container(
      padding: EdgeInsets.all(25.w),
      margin: EdgeInsets.symmetric(horizontal: 20.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.blue.shade50.withOpacity(0.5)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.blue.withOpacity(0.1), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withOpacity(0.05),
            blurRadius: 20,
            spreadRadius: 5,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.assignment_turned_in_rounded,
                color: AppColors.colorButtonLight,
                size: 28.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                isAr ? "معلومات التقرير" : "Report Information",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: AppColors.colorButtonLight,
                      fontSize: 20.sp,
                    ),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          Divider(color: Colors.grey.shade200, thickness: 1.5),
          SizedBox(height: 15.h),
          _buildInfoRow(
            isAr ? "الحالة:" : "Status:",
            data.status.toUpperCase(),
            data.status.toLowerCase() == 'done'
                ? Colors.green.shade600
                : Colors.orange.shade600,
            icon: data.status.toLowerCase() == 'done'
                ? Icons.check_circle_outline
                : Icons.hourglass_empty,
          ),
          SizedBox(height: 15.h),
          _buildInfoRow(
            isAr ? "تاريخ البدء:" : "Started at:",
            createdStr,
            Colors.black87,
            icon: Icons.access_time_rounded,
          ),
          if (completedStr.isNotEmpty) ...[
            SizedBox(height: 15.h),
            _buildInfoRow(
              isAr ? "تاريخ الانتهاء:" : "Completed at:",
              completedStr,
              Colors.black87,
              icon: Icons.done_all_rounded,
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value,
    Color valueColor, {
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 12.w),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 20.sp, color: valueColor),
            SizedBox(width: 8.w),
          ],
          Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.black87.withOpacity(0.6),
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: TextStyle(
              fontSize: 14.sp,
              color: valueColor,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }
}
