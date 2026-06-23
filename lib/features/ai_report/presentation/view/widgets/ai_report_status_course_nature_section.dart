import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/course_nature_card.dart';
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
                isAr ? 'طبيعة المقرر' : 'Course Nature',
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
                child: CourseNatureCard(
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
                child: CourseNatureCard(
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
