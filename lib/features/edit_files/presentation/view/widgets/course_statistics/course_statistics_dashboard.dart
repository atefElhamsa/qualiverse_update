import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'components/comment_section_widget.dart';
import 'utils/pdf_export_helper.dart';

class CourseStatisticsDashboard extends StatefulWidget {
  final GetFileDataModel data;

  const CourseStatisticsDashboard({super.key, required this.data});

  @override
  State<CourseStatisticsDashboard> createState() =>
      _CourseStatisticsDashboardState();
}

class _CourseStatisticsDashboardState extends State<CourseStatisticsDashboard> {
  final ScreenshotController screenshotController = ScreenshotController();
  bool _isCapturing = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.w),
      child: Screenshot(
        controller: screenshotController,
        child: Container(
          padding: EdgeInsets.all(20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(width: 48),
                  Expanded(
                    child: DashboardHeader(
                      data: widget.data,
                    ).animate().fadeIn(duration: 600.ms).slideY(begin: -0.2),
                  ),
                  if (!_isCapturing)
                    IconButton(
                      onPressed: () async {
                        setState(() => _isCapturing = true);
                        await Future.delayed(const Duration(milliseconds: 100));
                        final imageBytes = await screenshotController.capture();
                        setState(() => _isCapturing = false);

                        if (imageBytes != null && context.mounted) {
                          await PdfExportHelper.generateAndPrintAnalysisPdf(
                            context,
                            widget.data,
                            imageBytes,
                          );
                        }
                      },
                      icon: Icon(
                        Icons.picture_as_pdf,
                        color: const Color(0xFF0F569E),
                        size: 30.sp,
                      ),
                      tooltip: 'download'.tr(),
                    )
                  else
                    const SizedBox(width: 48),
                ],
              ),
              SizedBox(height: 20.h),
              SummaryCardsRow(data: widget.data)
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 600.ms)
                  .slideY(begin: 0.1),
              SizedBox(height: 30.h),
              GradeDistributionSection(data: widget.data)
                  .animate()
                  .fadeIn(delay: 400.ms, duration: 600.ms)
                  .scale(begin: const Offset(0.95, 0.95)),
              SizedBox(height: 30.h),
              CommentSectionWidget(data: widget.data)
                  .animate()
                  .fadeIn(delay: 600.ms, duration: 600.ms)
                  .slideY(begin: 0.1),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }
}
