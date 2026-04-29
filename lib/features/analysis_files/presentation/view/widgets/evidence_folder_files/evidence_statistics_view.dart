import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/analysis_files/data/model/evidence_statistics_model.dart';

class EvidenceStatisticsView extends StatefulWidget {
  final EvidenceStatisticsModel statistics;
  const EvidenceStatisticsView({super.key, required this.statistics});

  @override
  State<EvidenceStatisticsView> createState() => _EvidenceStatisticsViewState();
}

class _EvidenceStatisticsViewState extends State<EvidenceStatisticsView> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.mainBlack : const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20.r)),
      ),
      child: SingleChildScrollView(
        padding: EdgeInsets.all(24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildManagementStats(context, isDark),
            SizedBox(height: 32.h),
            Text(
              'Academic Performance Analysis',
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white : AppColors.mainBlack,
              ),
            ),
            SizedBox(height: 20.h),
            _buildHorizontalGradeBars(context, isDark),
          ],
        ),
      ),
    );
  }

  Widget _buildManagementStats(BuildContext context, bool isDark) {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: isDark ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildSimpleInfo('Total', widget.statistics.totalStudents.toString(), AppColors.blue),
            VerticalDivider(color: isDark ? Colors.white10 : Colors.black12, thickness: 1, indent: 5, endIndent: 5),
            _buildSimpleInfo('Passed', widget.statistics.passedWritten.toString(), AppColors.green),
            VerticalDivider(color: isDark ? Colors.white10 : Colors.black12, thickness: 1, indent: 5, endIndent: 5),
            _buildSimpleInfo('Success', widget.statistics.passPercentageAfterExam, Colors.orange),
          ],
        ),
      ),
    );
  }

  Widget _buildSimpleInfo(String label, String value, Color color) {
    return Column(
      children: [
        Text(
          value,
          style: GoogleFonts.cairo(
            fontSize: 20.sp,
            fontWeight: FontWeight.w900,
            color: color,
          ),
        ),
        Text(
          label,
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            color: AppColors.greyLight,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalGradeBars(BuildContext context, bool isDark) {
    final grades = _getGradesData().where((g) => g.value > 0).toList();
    
    return Column(
      children: List.generate(grades.length, (index) {
        final g = grades[index];
        final percent = (g.value / widget.statistics.totalStudents);
        
        return TweenAnimationBuilder<double>(
          tween: Tween(begin: 0, end: 1),
          duration: Duration(milliseconds: 600 + (index * 150)),
          builder: (context, val, child) {
            return Container(
              margin: EdgeInsets.only(bottom: 20.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grade ${g.key}',
                        style: GoogleFonts.cairo(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : AppColors.mainBlack,
                        ),
                      ),
                      Text(
                        '${g.value} Students (${(percent * 100).toInt()}%)',
                        style: GoogleFonts.cairo(
                          fontSize: 12.sp,
                          color: AppColors.greyLight,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Stack(
                    children: [
                      Container(
                        height: 12.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: isDark ? Colors.white.withOpacity(0.05) : Colors.black.withOpacity(0.05),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                      FractionallySizedBox(
                        widthFactor: percent * val,
                        child: Container(
                          height: 12.h,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                _getGradeColor(g.key),
                                _getGradeColor(g.key).withOpacity(0.6),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10.r),
                            boxShadow: [
                              BoxShadow(
                                color: _getGradeColor(g.key).withOpacity(0.2),
                                blurRadius: 6,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      }),
    );
  }

  List<MapEntry<String, int>> _getGradesData() {
    return [
      MapEntry('A+', widget.statistics.gradeAPlus),
      MapEntry('A', widget.statistics.gradeA),
      MapEntry('A-', widget.statistics.gradeAMinus),
      MapEntry('B+', widget.statistics.gradeBPlus ?? 0),
      MapEntry('B', widget.statistics.gradeB ?? 0),
      MapEntry('B-', widget.statistics.gradeBMinus ?? 0),
      MapEntry('C+', widget.statistics.gradeCPlus ?? 0),
      MapEntry('C', widget.statistics.gradeC ?? 0),
      MapEntry('C-', widget.statistics.gradeCMinus ?? 0),
      MapEntry('D+', widget.statistics.gradeDPlus ?? 0),
      MapEntry('D', widget.statistics.gradeD ?? 0),
      MapEntry('D-', widget.statistics.gradeDMinus ?? 0),
      MapEntry('F', widget.statistics.gradeF ?? 0),
    ];
  }

  Color _getGradeColor(String grade) {
    if (grade.startsWith('A')) return AppColors.progressColor;
    if (grade.startsWith('B')) return AppColors.blue;
    if (grade.startsWith('C')) return Colors.orange;
    if (grade.startsWith('D')) return Colors.deepOrange;
    return AppColors.red;
  }
}
