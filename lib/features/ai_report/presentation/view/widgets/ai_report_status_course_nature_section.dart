import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportStatusCourseNatureSection extends StatelessWidget {
  final String? selectedCourseNature;
  final bool isAr;

  const AiReportStatusCourseNatureSection({
    super.key,
    required this.selectedCourseNature,
    required this.isAr,
  });

  @override
  Widget build(BuildContext context) {
    // If null, default to practical visually
    final isPractical =
        selectedCourseNature == 'practical' || selectedCourseNature == null;
    final isClinical = selectedCourseNature == 'clinical';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.science,
                color: AppColors.colorButtonLight,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              Text(
                isAr ? 'طبيعة المقرر (اختياري)' : 'Course Nature (Optional)',
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorButtonLight,
                  fontSize: 16.sp,
                ),
              ),
            ],
          ),
          SizedBox(height: 14.h),
          Row(
            children: [
              Expanded(
                child: _CourseNatureCard(
                  isSelected: isPractical,
                  icon: Icons.science_rounded,
                  iconColor: Colors.green,
                  iconBgColor: Colors.green.withOpacity(0.15),
                  title: isAr ? 'Practical (العملي)' : 'Practical',
                  subtitle: isAr ? 'المقررات العملية' : 'Practical Courses',
                  isDefault: true,
                  isAr: isAr,
                  onTap: () => context
                      .read<AiReportStatusCubit>()
                      .selectCourseNature('practical'),
                ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: _CourseNatureCard(
                  isSelected: isClinical,
                  icon: Icons.local_hospital_rounded,
                  iconColor: AppColors.colorButtonLight,
                  iconBgColor: AppColors.colorButtonLight.withOpacity(0.15),
                  title: isAr ? 'Clinical (الإكلينيكي)' : 'Clinical',
                  subtitle: isAr ? 'المقررات الإكلينيكية' : 'Clinical Courses',
                  isDefault: false,
                  isAr: isAr,
                  onTap: () => context
                      .read<AiReportStatusCubit>()
                      .selectCourseNature('clinical'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CourseNatureCard extends StatelessWidget {
  final bool isSelected;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  final String title;
  final String subtitle;
  final bool isDefault;
  final bool isAr;
  final VoidCallback onTap;

  const _CourseNatureCard({
    required this.isSelected,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    required this.title,
    required this.subtitle,
    required this.isDefault,
    required this.isAr,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colorButtonLight.withOpacity(0.04)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.colorButtonLight
                : Colors.grey.withOpacity(0.2),
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              isSelected
                  ? Icons.radio_button_checked_rounded
                  : Icons.radio_button_unchecked_rounded,
              color: isSelected
                  ? AppColors.colorButtonLight
                  : Colors.grey.shade400,
              size: 18.sp,
            ),
            SizedBox(width: 10.w),
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 18.sp),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Flexible(
                        child: Text(
                          title,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13.sp,
                            color: AppColors.mainBlack,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (isDefault) ...[
                        SizedBox(width: 4.w),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 6.w,
                            vertical: 2.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.green.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6.r),
                          ),
                          child: Text(
                            isAr ? "افتراضي" : "Default",
                            style: TextStyle(
                              color: Colors.green.shade700,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 11.sp,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
