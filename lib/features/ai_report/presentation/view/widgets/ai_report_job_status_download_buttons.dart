import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:open_filex/open_filex.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportJobStatusDownloadButtons extends StatelessWidget {
  final AiReportJobStatusData data;
  final bool isAr;

  const AiReportJobStatusDownloadButtons({
    super.key,
    required this.data,
    required this.isAr,
  });

  Future<void> _downloadFile(
    BuildContext context,
    int fileId,
    String fileName,
  ) async {
    try {
      final FileSaveLocation? result = await getSaveLocation(
        suggestedName: fileName,
      );
      if (result == null) {
        return; // User canceled
      }

      final savePath = result.path;

      await AiReportService.downloadReportFile(fileId, savePath);
      await OpenFilex.open(savePath);
    } catch (e) {
      final isAr = context.locale.languageCode == 'ar';
      showSnackBar(
        context,
        isAr
            ? "الخادم غير متصل. الموديل أوفلاين حالياً."
            : "Download failed: Server is offline.",
        AppColors.red,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        children: [
          if (data.files != null && data.files!.isNotEmpty)
            ...data.files!.map((file) {
              final isPdf =
                  file.fileType.toLowerCase().contains('pdf') ||
                  file.fileName.toLowerCase().endsWith('.pdf');
              final isWord =
                  file.fileType.toLowerCase().contains('word') ||
                  file.fileType.toLowerCase().contains('document') ||
                  file.fileName.toLowerCase().endsWith('.docx');

              final bgColor = isPdf
                  ? const Color(0xFFE53935)
                  : (isWord
                        ? const Color(0xFF1E88E5)
                        : const Color(0xFF43A047));
              final icon = isPdf
                  ? Icons.picture_as_pdf_rounded
                  : (isWord
                        ? Icons.description_rounded
                        : Icons.insert_drive_file_rounded);

              return Padding(
                padding: EdgeInsets.only(bottom: 15.h),
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: bgColor,
                    foregroundColor: Colors.white,
                    elevation: 4,
                    shadowColor: bgColor.withOpacity(0.5),
                    minimumSize: const Size(double.infinity, 55),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                  onPressed: () =>
                      _downloadFile(context, file.id, file.fileName),
                  icon: Icon(icon, size: 24.sp),
                  label: Text(
                    isAr
                        ? "تحميل ${file.fileName}"
                        : "Download ${file.fileName}",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              );
            })
          else
            Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: Text(
                isAr
                    ? "لا توجد ملفات للتحميل"
                    : "No files available for download",
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            ),
          SizedBox(height: 20.h),
          TextButton.icon(
            style: TextButton.styleFrom(
              backgroundColor: AppColors.colorButtonLight,
              foregroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            onPressed: () async {
              if (data.aiRequestId == null) {
                showSnackBar(
                  context,
                  isAr ? 'رقم الطلب غير متوفر' : 'Request ID is not available',
                  AppColors.red,
                );
                return;
              }

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) =>
                    const Center(child: CircularProgressIndicator()),
              );

              try {
                final response = await AiReportService.publishReport(
                  data.aiRequestId!,
                );
                if (!context.mounted) return;
                Navigator.pop(context); // close dialog

                if (response.isSuccess) {
                  showSnackBar(
                    context,
                    isAr ? "تم النشر بنجاح" : "Published successfully",
                    AppColors.green,
                  );
                  context.pushReplacementNamed(AppRoutes.homeScreen);
                } else {
                  showSnackBar(
                    context,
                    response.error?.description ??
                        (isAr
                            ? 'حدث خطأ غير متوقع'
                            : 'An unexpected error occurred'),
                    AppColors.red,
                  );
                }
              } catch (e) {
                if (!context.mounted) return;
                Navigator.pop(context); // close dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            },
            icon: Icon(Icons.send_rounded, size: 20.sp),
            label: Text(
              isAr ? "تقديم التقرير" : "Submit Report",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
