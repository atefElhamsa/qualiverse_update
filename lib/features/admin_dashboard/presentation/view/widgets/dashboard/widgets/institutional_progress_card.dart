import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'common_dashboard_widgets.dart';

class InstitutionalProgressCard extends StatelessWidget {
  final int totalIndicators;
  final int indicatorsWithFiles;
  final int percentage;

  const InstitutionalProgressCard({
    super.key,
    required this.totalIndicators,
    required this.indicatorsWithFiles,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return BaseDashboardCard(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomText(
                title: 'institutionalIndicatorsProgress'.tr(),
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 15.sp,
                  color: AppColors.mainBlack,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.info_outline,
                size: 13.sp,
                color: AppColors.textGrey.withOpacity(0.5),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Left side: Donut Chart
              Expanded(
                flex: 3,
                child: Container(
                  height: 180.h,
                  alignment: Alignment.center,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 140.w,
                        height: 140.w,
                        child: CircularProgressIndicator(
                          value: percentage / 100,
                          strokeWidth: 15.w,
                          backgroundColor: const Color(0xFFE2E8F0),
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.blue,
                          ),
                          strokeCap: StrokeCap.round,
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CustomText(
                            title: "$percentage%",
                            textStyle: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.w900,
                              color: AppColors.mainBlack,
                            ),
                          ),
                          CustomText(
                            title: 'progress'.tr(),
                            textStyle: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().scale(duration: 800.ms, curve: Curves.easeOutBack),
              ),
              SizedBox(width: 40.w),
              // Right side: 3 Small Cards
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: _infoDetailCard(
                            context,
                            'totalIndicators'.tr(),
                            totalIndicators.toString(),
                            Icons.format_list_bulleted_rounded,
                            AppColors.blue,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _infoDetailCard(
                            context,
                            'withFiles'.tr(),
                            indicatorsWithFiles.toString(),
                            Icons.insert_drive_file_rounded,
                            AppColors.green,
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: _infoDetailCard(
                            context,
                            'progress'.tr(),
                            "$percentage%",
                            Icons.pie_chart_rounded,
                            AppColors.blue,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 32.h),
                    // Large Progress Bar below cards
                    Column(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child: LinearProgressIndicator(
                            value: percentage / 100,
                            minHeight: 12.h,
                            backgroundColor: const Color(0xFFE2E8F0),
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              AppColors.blue,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomText(
                          title: "$indicatorsWithFiles / $totalIndicators",
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 32.h),
          const Divider(height: 1, color: Color(0xFFF1F5F9)),
          SizedBox(height: 20.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.info_outline,
                size: 13.sp,
                color: AppColors.textGrey.withOpacity(0.5),
              ),
              SizedBox(width: 10.w),
              CustomText(
                title: 'institutionalPercentageNote'.tr(),
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.textGrey.withOpacity(0.6),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ],
      ),
    ).animate().fadeIn(duration: 600.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _infoDetailCard(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Row(
        children: [
          Icon(icon, color: color, size: 30.sp),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomText(
                  title: label,
                  textStyle: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textGrey,
                  ),
                ),
                SizedBox(height: 4.h),
                CustomText(
                  title: value,
                  textStyle: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.mainBlack,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
