import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SummaryCardsRow extends StatelessWidget {
  final GetFileDataModel data;
  const SummaryCardsRow({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 2,
          child: TotalStudentsCard(count: data.totalStudents),
        ),
        SizedBox(width: 15.w),
        Expanded(
          flex: 5,
          child: AttendanceSummaryCard(
            total: data.totalStudents,
            attended: data.attendedExam,
            absent: data.absent,
            absentWithExcuse: data.absentWithExcuse,
            deprived: data.deprived,
          ),
        ),
        SizedBox(width: 15.w),
        Expanded(
          flex: 3,
          child: PassingRateCard(
            passPercentage: data.passPercentageAfterExam,
            passedCount: data.passedWrittenAndYearWork,
            totalCount: data.totalStudents,
          ),
        ),
      ],
    );
  }
}
