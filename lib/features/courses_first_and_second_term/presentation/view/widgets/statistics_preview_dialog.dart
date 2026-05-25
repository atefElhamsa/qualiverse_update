import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// Import Components
import 'statistics_preview_components/summary_cards.dart';
import 'statistics_preview_components/course_mapping_table.dart';
import 'statistics_preview_components/unmatched_warning.dart';
import 'statistics_preview_components/statistics_preview_header.dart';
import 'statistics_preview_components/dialog_footer.dart';

class StatisticsPreviewDialog extends StatefulWidget {
  final StatisticsPreviewData data;
  final CourseArgs courseArgs;
  final EvidenceFolderFilesCubit evidenceCubit;

  const StatisticsPreviewDialog({
    super.key,
    required this.data,
    required this.courseArgs,
    required this.evidenceCubit,
  });

  @override
  State<StatisticsPreviewDialog> createState() =>
      _StatisticsPreviewDialogState();
}

class _StatisticsPreviewDialogState extends State<StatisticsPreviewDialog> {
  late Map<int, int?> selectedMappings;

  @override
  void initState() {
    super.initState();
    selectedMappings = {
      for (var row in widget.data.rows) row.rowIndex: row.matchedCourseId,
    };
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        CourseCubit.get(context).reset();
        CourseCubit.get(context).fetchCourses(
          yearId: widget.courseArgs.yearId,
          levelId: widget.courseArgs.levelId,
          semesterId: widget.courseArgs.termModel.id,
          departmentId: widget.courseArgs.departmentId,
          lang: 'ar',
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final matchedCount = selectedMappings.values.where((v) => v != null).length;
    final unmatchedCount = selectedMappings.length - matchedCount;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
      elevation: 20,
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
      child: Container(
        width: 1000.w,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StatisticsPreviewHeader(onClose: () => Navigator.pop(context)),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 25.h),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SummaryCardsSection(
                      matchedCount: matchedCount,
                      unmatchedCount: unmatchedCount,
                    ),
                    SizedBox(height: 35.h),
                    _SectionHeader(title: "coursesList".tr()),
                    SizedBox(height: 15.h),
                    BlocBuilder<CourseCubit, CourseState>(
                      builder: (context, state) {
                        final courses = (state is CourseSuccess)
                            ? state.courses
                            : CourseCubit.get(context).courses;
                        final isLoading = state is CourseLoading;

                        if (isLoading && courses.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(20.0),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        return CourseMappingTable(
                          rows: widget.data.rows,
                          availableCourses: courses,
                          selectedMappings: selectedMappings,
                          onMappingChanged: (rowIndex, courseId) {
                            setState(
                              () => selectedMappings[rowIndex] = courseId,
                            );
                          },
                        );
                      },
                    ),
                    if (unmatchedCount > 0) ...[
                      SizedBox(height: 25.h),
                      const UnmatchedWarning(),
                    ],
                  ],
                ),
              ),
            ),
            DialogFooter(
              onCancel: () => Navigator.pop(context),
              onConfirm: () {
                Navigator.pop(context);
                final overrides = selectedMappings.entries
                    .where((e) => e.value != null)
                    .map((e) => {"rowIndex": e.key, "courseId": e.value})
                    .toList();

                widget.evidenceCubit.confirmStatisticsUpload(
                  previewId: widget.data.previewId,
                  courseOverrides: overrides,
                  academicYearId: widget.courseArgs.yearId,
                  termId: widget.courseArgs.termModel.id,
                  levelId: widget.courseArgs.levelId,
                  departmentId: widget.courseArgs.departmentId,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 4.w,
          height: 20.h,
          decoration: BoxDecoration(
            color: AppColors.progressColor,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
        SizedBox(width: 12.w),
        Text(
          title,
          style: GoogleFonts.almarai(
            fontWeight: FontWeight.bold,
            fontSize: 17.sp,
            color: const Color(0xFF334155),
          ),
        ),
      ],
    );
  }
}
