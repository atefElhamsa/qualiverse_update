import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_status_model.dart';

class AiReportStatusHealthCard extends StatelessWidget {
  final AiReportHealthModel health;
  final bool isAr;

  const AiReportStatusHealthCard({
    super.key,
    required this.health,
    required this.isAr,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOnline = health.status.toLowerCase() == 'ok';
    final serverTime = DateTime.tryParse(health.timestamp) ?? DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm:ss').format(serverTime);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: Colors.grey.withOpacity(0.08)),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(25.r),
          child: Column(
            children: [
              // Header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                color: AppColors.colorButtonLight.withOpacity(0.04),
                child: Row(
                  children: [
                    Icon(
                      Icons.settings_suggest_rounded,
                      color: AppColors.colorButtonLight,
                      size: 24.sp,
                    ),
                    SizedBox(width: 12.w),
                    Text(
                      isAr ? "صحة النظام" : "System Health",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorButtonLight,
                        fontSize: 18.sp,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: isOnline
                            ? AppColors.green.withOpacity(0.1)
                            : AppColors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 8.r,
                            height: 8.r,
                            decoration: BoxDecoration(
                              color: isOnline ? AppColors.green : AppColors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            isOnline
                                ? (isAr ? "متصل" : "Online")
                                : (isAr ? "غير متصل" : "Offline"),
                            style: TextStyle(
                              color: isOnline ? AppColors.green : AppColors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 12.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(height: 1, color: Color(0xFFEEEEEE)),
              // Info List
              Padding(
                padding: EdgeInsets.all(20.r),
                child: Column(
                  children: [
                    _HealthInfoRow(
                      label: isAr
                          ? "المزود النشط حالياً"
                          : "Active AI Provider",
                      value: health.provider.toUpperCase(),
                      icon: Icons.api_rounded,
                    ),
                    SizedBox(height: 12.h),
                    _HealthInfoRow(
                      label: isAr ? "إصدار الخدمة" : "Service Version",
                      value: health.version,
                      icon: Icons.code_rounded,
                    ),
                    SizedBox(height: 12.h),
                    _HealthInfoRow(
                      label: isAr ? "توقيت الخادم" : "Server Time",
                      value: formattedTime,
                      icon: Icons.schedule_rounded,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HealthInfoRow extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _HealthInfoRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.textGrey, size: 20.sp),
        SizedBox(width: 12.w),
        Text(
          label,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
            color: AppColors.textGrey,
            fontSize: 14.sp,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.mainBlack,
            fontSize: 14.sp,
          ),
        ),
      ],
    );
  }
}
