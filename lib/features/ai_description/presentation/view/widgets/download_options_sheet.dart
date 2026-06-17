import 'package:easy_localization/easy_localization.dart';
import 'package:file_selector/file_selector.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:qualiverse/features/login/presentation/view/widgets/error_widget.dart';

class DownloadOptionsSheet extends StatelessWidget {
  final AiDescriptionCubit cubit;

  const DownloadOptionsSheet({super.key, required this.cubit});

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
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildOption(
            context,
            icon: Icons.picture_as_pdf,
            color: AppColors.red,
            title: "downloadPDF".tr(),
            onTap: () {
              Navigator.pop(context);
              String url =
                  cubit.pdfUrl ??
                  EndPoints.downloadFiles(cubit.generationId ?? "", 1);
              _downloadFile(
                context,
                url,
                cubit.pdfName ?? 'course_description.pdf',
              );
            },
          ),
          _buildOption(
            context,
            icon: Icons.description,
            color: AppColors.blue,
            title: "downloadWord".tr(),
            onTap: () {
              Navigator.pop(context);
              String url =
                  cubit.docxUrl ??
                  EndPoints.downloadFiles(cubit.generationId ?? "", 0);
              _downloadFile(
                context,
                url,
                cubit.docxName ?? 'course_description.docx',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildOption(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      onTap: onTap,
    );
  }
}
