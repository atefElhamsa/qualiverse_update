import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/features/edit_files/data/models/statistics_preview_model.dart';

// Import Cells
import 'cells/course_info_cell.dart';
import 'cells/course_selection_cell.dart';
import 'cells/match_score_badge.dart';
import 'cells/status_indicator.dart';

class CourseMappingTable extends StatelessWidget {
  final List<StatisticsPreviewRow> rows;
  final List<CourseModel> availableCourses;
  final Map<int, int?> selectedMappings;
  final Function(int, int?) onMappingChanged;

  const CourseMappingTable({
    super.key,
    required this.rows,
    required this.availableCourses,
    required this.selectedMappings,
    required this.onMappingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.01),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.r),
        child: SizedBox(
          width: double.infinity,
          child: DataTable(
            headingRowColor: MaterialStateProperty.all(const Color(0xFFF8FAFC)),
            dataRowHeight: 85.h,
            headingRowHeight: 60.h,
            columnSpacing: 40.w,
            dividerThickness: 1,
            horizontalMargin: 25.w,
            columns: [
              _buildHeaderCell("fileCourseName".tr()),
              _buildHeaderCell("matchedSystemCourse".tr()),
              _buildHeaderCell("matchScore".tr(), isCenter: true),
              _buildHeaderCell("status".tr(), isCenter: true),
            ],
            rows: List.generate(rows.length, (index) {
              final row = rows[index];
              final currentSelectedId = selectedMappings[row.rowIndex];
              final isMatched = currentSelectedId != null;
              final isEven = index % 2 == 0;

              return DataRow(
                color: MaterialStateProperty.all(
                  isEven ? Colors.white : const Color(0xFFFBFCFE),
                ),
                cells: [
                  DataCell(CourseInfoCell(name: row.fileCourseName)),
                  DataCell(
                    CourseSelectionCell(
                      currentSelectedId: currentSelectedId,
                      availableCourses: availableCourses,
                      isMatched: isMatched,
                      onChanged: (newId) =>
                          onMappingChanged(row.rowIndex, newId),
                    ),
                  ),
                  DataCell(
                    Center(child: MatchScoreBadge(score: row.matchScore)),
                  ),
                  DataCell(
                    Center(child: StatusIndicator(isMatched: isMatched)),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  DataColumn _buildHeaderCell(String title, {bool isCenter = false}) {
    return DataColumn(
      label: isCenter
          ? Expanded(
              child: Center(
                child: Text(
                  title,
                  style: GoogleFonts.almarai(
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF64748B),
                    fontSize: 13.sp,
                  ),
                ),
              ),
            )
          : Text(
              title,
              style: GoogleFonts.almarai(
                fontWeight: FontWeight.w800,
                color: const Color(0xFF64748B),
                fontSize: 13.sp,
              ),
            ),
    );
  }
}
