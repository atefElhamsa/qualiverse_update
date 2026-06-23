import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_history_model.dart';
import 'package:qualiverse/routing/app_routes.dart';
import 'package:qualiverse/features/edit_files/data/models/course_folder_args.dart';
import 'package:qualiverse/features/courses_first_and_second_term/data/models/course_model.dart';

class AiReportHistoryCard extends StatefulWidget {
  final AiReportHistoryItem item;
  final VoidCallback onPublish;

  const AiReportHistoryCard({
    super.key,
    required this.item,
    required this.onPublish,
  });

  @override
  State<AiReportHistoryCard> createState() => _AiReportHistoryCardState();
}

class _AiReportHistoryCardState extends State<AiReportHistoryCard> {
  @override
  Widget build(BuildContext context) {
    bool isPublished = widget.item.isPublished;
    bool hasFiles = widget.item.files.isNotEmpty;

    // Status Logic
    String statusText;
    Color statusBgColor;
    Color statusTextColor;
    IconData? statusIcon;

    bool isArabic = context.locale.languageCode == 'ar';

    if (isPublished) {
      statusText = isArabic ? 'منشور' : 'Published';
      statusBgColor = AppColors.green.withOpacity(0.15);
      statusTextColor = AppColors.green;
      statusIcon = Icons.check;
    } else if (hasFiles) {
      statusText = isArabic ? 'جاهز للنشر' : 'Ready to Publish';
      statusBgColor = AppColors.blue.withOpacity(0.15);
      statusTextColor = AppColors.blue;
      statusIcon = Icons.access_time;
    } else {
      statusText = isArabic ? 'مسودة' : 'Draft';
      statusBgColor = AppColors.mainGrey.withOpacity(0.15);
      statusTextColor = AppColors.mainGrey;
      statusIcon = Icons.circle;
    }

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainBlack.withOpacity(0.04),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
          border: Border.all(color: AppColors.grey.withOpacity(0.15)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Icon Box
            Container(
              width: 60.w,
              height: 60.w,
              decoration: BoxDecoration(
                color: _getIconBgColor(widget.item.courseCode),
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Icon(
                _getCourseIcon(widget.item.courseCode),
                color: _getIconColor(widget.item.courseCode),
                size: 30.sp,
              ),
            ),
            SizedBox(width: 16.w),

            // Course Info
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.item.courseCode ?? 'Course',
                    style: GoogleFonts.almarai(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainBlack,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Icon(
                        Icons.smart_toy_outlined,
                        size: 16.sp,
                        color: AppColors.mainBlack,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        widget.item.provider ?? 'OpenAI',
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: AppColors.mainBlack,
                        ),
                      ),
                      SizedBox(width: 16.w),
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 16.sp,
                        color: AppColors.mainGrey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDate(widget.item.createdOn),
                        style: GoogleFonts.almarai(
                          fontSize: 14.sp,
                          color: AppColors.mainGrey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Status Badge
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: statusBgColor,
                      borderRadius: BorderRadius.circular(20.r),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          statusText,
                          style: GoogleFonts.almarai(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w700,
                            color: statusTextColor,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(statusIcon, size: 16.sp, color: statusTextColor),
                      ],
                    ),
                  ),
                  SizedBox(height: 12.h),
                  Text(
                    isPublished
                        ? (isArabic
                              ? 'تم نشر التقرير في مجلد المقرر'
                              : 'Report published to folder')
                        : hasFiles
                        ? (isArabic
                              ? 'يمكنك الآن نشر التقرير'
                              : 'You can now publish the report')
                        : (isArabic
                              ? 'لم يتم إنشاء الملفات بعد'
                              : 'Files not generated yet'),
                    style: GoogleFonts.almarai(
                      fontSize: 12.sp,
                      color: AppColors.mainGrey,
                    ),
                  ),
                ],
              ),
            ),

            // Action Buttons
            Expanded(
              flex: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!hasFiles) ...[
                    // Draft State
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.mainGrey.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: AppColors.mainGrey.withOpacity(0.2),
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.folder_off_outlined,
                            size: 16.sp,
                            color: AppColors.mainGrey,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            isArabic ? 'لا توجد ملفات' : 'No files',
                            style: GoogleFonts.almarai(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w600,
                              color: AppColors.mainGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ] else ...[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: widget.item.files.map((file) {
                        final isPdf = file.fileType.toLowerCase().contains(
                          'pdf',
                        );
                        final isDocx = file.fileType.toLowerCase().contains(
                          'doc',
                        );
                        final label = isPdf
                            ? 'PDF'
                            : (isDocx ? 'DOCX' : 'FILE');
                        final color = isPdf
                            ? AppColors.red
                            : (isDocx ? AppColors.blue : AppColors.mainBlack);
                        final icon = isPdf
                            ? Icons.picture_as_pdf
                            : (isDocx
                                  ? Icons.description
                                  : Icons.insert_drive_file);

                        return Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: _buildFileButton(
                            label,
                            icon,
                            color,
                            false,
                            null, // Disabled file opening as requested
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 12.h),
                    isPublished
                        ? _buildActionButton(
                            isArabic ? 'فتح مجلد المقرر' : 'Open Folder',
                            Icons.folder_open,
                            AppColors.white,
                            AppColors.aiPrimary,
                            () {
                              // Open folder route (EditFilesScreen)
                              if (widget.item.courseId != null) {
                                context.push(
                                  AppRoutes.editFilesScreen,
                                  extra: CourseFolderArgs(
                                    courseModel: CourseModel(
                                      id: widget.item.courseId!,
                                      courseTemplateId: 0,
                                      code: widget.item.courseCode ?? "Course",
                                      name: widget.item.courseCode ?? "Course",
                                      levelId: 0,
                                      termId: 0,
                                      academicYearId: 0,
                                    ),
                                  ),
                                );
                              }
                            },
                          )
                        : _buildActionButton(
                            isArabic
                                ? 'نشر في ملفات المقرر'
                                : 'Publish to Folder',
                            Icons.cloud_upload_outlined,
                            AppColors.aiPrimary,
                            AppColors.white,
                            widget.onPublish,
                          ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFileButton(
    String label,
    IconData icon,
    Color color,
    bool isLoading,
    VoidCallback? onTap,
  ) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.grey),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          children: [
            if (isLoading)
              SizedBox(
                width: 16.sp,
                height: 16.sp,
                child: CircularProgressIndicator(strokeWidth: 2, color: color),
              )
            else
              Icon(icon, size: 16.sp, color: color),
            SizedBox(width: 4.w),
            Text(
              label,
              style: GoogleFonts.almarai(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainBlack,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    String label,
    IconData icon,
    Color bgColor,
    Color textColor,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 10.h),
        decoration: BoxDecoration(
          color: bgColor,
          border: bgColor == AppColors.white
              ? Border.all(color: AppColors.aiPrimary)
              : null,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: GoogleFonts.almarai(
                fontSize: 14.sp,
                fontWeight: FontWeight.w700,
                color: textColor,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(icon, size: 18.sp, color: textColor),
          ],
        ),
      ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null || dateStr.isEmpty) return 'N/A';
    try {
      final DateTime date = DateTime.parse(dateStr);
      return DateFormat('dd MMM yyyy - HH:mm').format(date);
    } catch (e) {
      return dateStr;
    }
  }

  // Helpers to simulate the different icons based on name length or hash
  IconData _getCourseIcon(String? code) {
    if (code == null) return Icons.insert_drive_file_outlined;
    final l = code.toLowerCase();
    if (l.contains('math')) return Icons.menu_book;
    if (l.contains('data')) return Icons.storage;
    if (l.contains('oper') || l.contains('os')) return Icons.memory;
    if (l.contains('net')) return Icons.language;
    return Icons.insert_drive_file_outlined;
  }

  Color _getIconBgColor(String? code) {
    if (code == null) return AppColors.greyLight.withOpacity(0.2);
    final l = code.toLowerCase();
    if (l.contains('math')) return Colors.purple.withOpacity(0.1);
    if (l.contains('data')) return Colors.blue.withOpacity(0.1);
    if (l.contains('oper') || l.contains('os'))
      return Colors.orange.withOpacity(0.1);
    if (l.contains('net')) return Colors.green.withOpacity(0.1);
    return AppColors.greyLight.withOpacity(0.2);
  }

  Color _getIconColor(String? code) {
    if (code == null) return AppColors.mainGrey;
    final l = code.toLowerCase();
    if (l.contains('math')) return Colors.purple;
    if (l.contains('data')) return Colors.blue;
    if (l.contains('oper') || l.contains('os')) return Colors.orange;
    if (l.contains('net')) return Colors.green;
    return AppColors.mainGrey;
  }
}
