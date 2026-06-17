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
    String? url,
    String fileName,
  ) async {
    if (url == null || url.isEmpty) {
      showSnackBar(context, "Download URL not available", AppColors.red);
      return;
    }

    final fullUrl = url.startsWith('http') ? url : '${EndPoints.baseUrl}$url';

    try {
      final isAr = context.locale.languageCode == 'ar';

      final FileSaveLocation? result = await getSaveLocation(
        suggestedName: fileName,
      );
      if (result == null) {
        return; // User canceled
      }

      final savePath = result.path;

      final dio = ApiClient.dio;
      final response = await dio.download(fullUrl, savePath);

      if (response.statusCode == 200) {
        await OpenFilex.open(savePath);
      } else {
        showSnackBar(
          context,
          isAr
              ? "الخادم غير متصل. الموديل أوفلاين حالياً."
              : "Server is offline.",
          AppColors.red,
        );
      }
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
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935), // Deeper red for PDF
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFFE53935).withOpacity(0.5),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            onPressed: () => _downloadFile(
              context,
              EndPoints.aiReportDownloadPdf(data.jobId),
              'report_${data.jobId}.pdf',
            ),
            icon: Icon(Icons.picture_as_pdf_rounded, size: 24.sp),
            label: Text(
              isAr ? "تحميل التقرير (PDF)" : "Download Report (PDF)",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 15.h),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF1E88E5), // Deeper blue for DOCX
              foregroundColor: Colors.white,
              elevation: 4,
              shadowColor: const Color(0xFF1E88E5).withOpacity(0.5),
              minimumSize: const Size(double.infinity, 55),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            onPressed: () => _downloadFile(
              context,
              EndPoints.aiReportDownloadDocx(data.jobId),
              'report_${data.jobId}.docx',
            ),
            icon: Icon(Icons.description_rounded, size: 24.sp),
            label: Text(
              isAr ? "تحميل التقرير (DOCX)" : "Download Report (DOCX)",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                letterSpacing: 0.5,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          TextButton.icon(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.colorButtonLight,
              minimumSize: const Size(double.infinity, 50),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.r),
              ),
            ),
            onPressed: () => context.pushReplacementNamed(AppRoutes.homeScreen),
            icon: Icon(Icons.home_rounded, size: 20.sp),
            label: Text(
              isAr ? "العودة للرئيسية" : "Back to Home",
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
    );
  }
}
