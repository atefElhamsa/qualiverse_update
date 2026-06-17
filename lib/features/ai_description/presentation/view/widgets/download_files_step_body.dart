import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class DownloadFilesStepBody extends StatelessWidget {
  final AiDescriptionCubit cubit;
  final VoidCallback onEdit;
  final VoidCallback onDownload;

  const DownloadFilesStepBody({
    super.key,
    required this.cubit,
    required this.onEdit,
    required this.onDownload,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 0.95.sw,
      padding: EdgeInsets.symmetric(vertical: 25.h, horizontal: 50.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 20,
            spreadRadius: 0,
          ),
        ],
        border: Border.all(color: Colors.transparent),
      ),
      child: Column(
        children: [
          _buildFilesRow(context),
          SizedBox(height: 20.h),
          AiDescriptionSubmitButton(cubit: cubit),
        ],
      ),
    );
  }

  String _getPdfTitle() {
    if (cubit.customPdfFile != null) {
      return cubit.customPdfFile!.path.split('/').last.split('\\').last;
    }
    return "PDF";
  }

  String _getDocxTitle() {
    if (cubit.customDocxFile != null) {
      return cubit.customDocxFile!.path.split('/').last.split('\\').last;
    }
    return "DOCX";
  }

  Widget _buildFilesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // PDF Section
        FileSectionWidget(
          title: _getPdfTitle(),
          icon: Icons.picture_as_pdf_rounded,
          iconColor: AppColors.aiPdf,
          isReady: cubit.pdfUrl != null || cubit.customPdfFile != null,
          actionTitle: "edit".tr(),
          actionIcon: Icons.edit_note_rounded,
          onAction: cubit.hasUploadedCustomFiles ? null : onEdit,
        ),
        // DOCX Section
        FileSectionWidget(
          title: _getDocxTitle(),
          icon: Icons.description_rounded,
          iconColor: AppColors.aiDocx,
          isReady: cubit.docxUrl != null || cubit.customDocxFile != null,
          actionTitle: "download".tr(),
          actionIcon: Icons.file_download_outlined,
          onAction: onDownload,
        ),
      ],
    );
  }
}
