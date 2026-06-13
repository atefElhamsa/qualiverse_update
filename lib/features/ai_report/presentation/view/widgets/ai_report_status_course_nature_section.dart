import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_status_cubit.dart';

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
    const options = ['practical', 'clinical'];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
          border: Border.all(color: Colors.grey.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.school_rounded,
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
            // None chip
            Wrap(
              spacing: 10.w,
              runSpacing: 8.h,
              children: [
                _NatureChip(
                  label: isAr ? 'بدون تحديد' : 'None',
                  icon: Icons.remove_circle_outline_rounded,
                  isSelected: selectedCourseNature == null,
                  onTap: () => context
                      .read<AiReportStatusCubit>()
                      .selectCourseNature(null),
                ),
                ...options.map(
                  (opt) => _NatureChip(
                    label: opt[0].toUpperCase() + opt.substring(1),
                    icon: opt == 'practical'
                        ? Icons.science_rounded
                        : Icons.local_hospital_rounded,
                    isSelected: selectedCourseNature == opt,
                    onTap: () => context
                        .read<AiReportStatusCubit>()
                        .selectCourseNature(opt),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _NatureChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _NatureChip({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.colorButtonLight
              : Colors.grey.withOpacity(0.06),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: isSelected
                ? AppColors.colorButtonLight
                : Colors.grey.withOpacity(0.2),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18.sp,
              color: isSelected ? Colors.white : Colors.grey.shade600,
            ),
            SizedBox(width: 8.w),
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
