import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/edit_files/data/models/get_file_data_model.dart';
import 'components/dashboard_header.dart';
import 'components/grade_distribution_section.dart';
import 'components/summary_cards_row.dart';

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
        ],
      ),
    );
  }
}
