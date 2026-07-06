import 'dart:ui' as ui;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CommentSectionWidget extends StatelessWidget {
  final GetFileDataModel data;

  const CommentSectionWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    bool isAr = context.locale.languageCode == 'ar';

    Map<String, int> grades = {
      'A+': data.gradeAPlus ?? 0,
      'A': data.gradeA ?? 0,
      'A-': data.gradeAMinus ?? 0,
      'B+': data.gradeBPlus ?? 0,
      'B': data.gradeB ?? 0,
      'B-': data.gradeBMinus ?? 0,
      'C+': data.gradeCPlus ?? 0,
      'C': data.gradeC ?? 0,
      'C-': data.gradeCMinus ?? 0,
      'D+': data.gradeDPlus ?? 0,
      'D': data.gradeD ?? 0,
      'D-': data.gradeDMinus ?? 0,
      'F': data.gradeF ?? 0,
    };

    var highestGradeEntry = grades.entries.reduce((a, b) => a.value > b.value ? a : b);
    
    int passed = data.passedWrittenAndYearWork;
    int total = data.totalStudents;
    String passPercentage = data.passPercentageAfterExam;
    int failed = data.gradeF ?? 0;

    final primaryColor = const Color(0xFF0F569E);
    final textColor = const Color(0xFF334155);

    List<Widget> buildPoints() {
      return [
        _buildAnalysisRow(
          icon: Icons.groups_outlined,
          title: isAr ? 'إجمالي عدد الطلاب:' : 'Total students:',
          value: '$total',
          suffix: isAr ? 'طالب' : 'students',
          primaryColor: primaryColor,
          textColor: textColor,
          isAr: isAr,
        ),
        _buildAnalysisRow(
          icon: Icons.percent_outlined,
          title: isAr ? 'نسبة النجاح:' : 'Pass percentage:',
          value: passPercentage,
          suffix: '',
          primaryColor: primaryColor,
          textColor: textColor,
          isAr: isAr,
        ),
        _buildAnalysisRow(
          icon: Icons.check_circle_outline,
          title: isAr ? 'عدد الطلاب الناجحين:' : 'Passed students:',
          value: '$passed',
          suffix: isAr ? 'من أصل $total' : 'out of $total',
          primaryColor: Colors.green.shade600,
          textColor: textColor,
          isAr: isAr,
        ),
        _buildAnalysisRow(
          icon: Icons.cancel_outlined,
          title: isAr ? 'عدد الطلاب الراسبين:' : 'Failed students:',
          value: '$failed',
          suffix: isAr ? 'طالب' : 'students',
          primaryColor: Colors.red.shade600,
          textColor: textColor,
          isAr: isAr,
        ),
        _buildAnalysisRow(
          icon: Icons.star_outline,
          title: isAr ? 'الدرجة الأكثر تكراراً هي' : 'Most frequent grade is',
          value: '(${highestGradeEntry.key})',
          suffix: isAr 
            ? 'بعدد ${highestGradeEntry.value} طالب/طلاب' 
            : 'achieved by ${highestGradeEntry.value} student(s)',
          primaryColor: Colors.amber.shade700,
          textColor: textColor,
          isAr: isAr,
        ),
      ];
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.auto_awesome, color: Colors.amber.shade600, size: 20.sp),
            SizedBox(width: 8.w),
            Text(
              isAr ? "التحليل الآلي للنتائج" : "Auto-generated Analysis",
              style: GoogleFonts.almarai(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF1E293B),
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: const Color(0xFFF8FAFC),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: const Color(0xFFE2E8F0)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.02),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Directionality(
            textDirection: isAr ? ui.TextDirection.rtl : ui.TextDirection.ltr,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: buildPoints(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisRow({
    required IconData icon,
    required String title,
    required String value,
    required String suffix,
    required Color primaryColor,
    required Color textColor,
    required bool isAr,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(6.w),
            decoration: BoxDecoration(
              color: primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: primaryColor, size: 16.sp),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 4.h),
              child: RichText(
                text: TextSpan(
                  style: GoogleFonts.almarai(
                    color: textColor,
                    fontSize: 14.sp,
                    height: 1.5,
                  ),
                  children: [
                    TextSpan(text: '$title '),
                    TextSpan(
                      text: value,
                      style: GoogleFonts.almarai(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.sp,
                      ),
                    ),
                    if (suffix.isNotEmpty) TextSpan(text: ' $suffix'),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

