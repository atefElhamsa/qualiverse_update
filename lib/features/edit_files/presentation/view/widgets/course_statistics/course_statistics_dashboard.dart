import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'components/comment_section_widget.dart';

class CourseStatisticsDashboard extends StatelessWidget {
  final GetFileDataModel data;

  const CourseStatisticsDashboard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DashboardHeader(
            data: data,
          ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
          SizedBox(height: 20.h),
          SummaryCardsRow(data: data)
              .animate()
              .fadeIn(delay: 200.ms, duration: 600.ms)
              .slideY(begin: 0.1),
          SizedBox(height: 30.h),
          GradeDistributionSection(data: data)
              .animate()
              .fadeIn(delay: 400.ms, duration: 600.ms)
              .scale(begin: const Offset(0.95, 0.95)),
          SizedBox(height: 30.h),
          CommentSectionWidget(data: data)
              .animate()
              .fadeIn(delay: 600.ms, duration: 600.ms)
              .slideY(begin: 0.1),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
