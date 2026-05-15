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

  Widget _buildFilesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // PDF Section
        FileSectionWidget(
          title: cubit.pdfName ?? "evaluation.pdf",
          icon: Icons.picture_as_pdf_rounded,
          iconColor: AppColors.aiPdf,
          isReady: cubit.pdfUrl != null,
          actionTitle: "edit".tr(),
          actionIcon: Icons.edit_note_rounded,
          onAction: onEdit,
        ),
        // DOCX Section
        FileSectionWidget(
          title: cubit.docxName ?? "evaluation.docx",
          icon: Icons.description_rounded,
          iconColor: AppColors.aiDocx,
          isReady: cubit.docxUrl != null,
          actionTitle: "download".tr(),
          actionIcon: Icons.file_download_outlined,
          onAction: onDownload,
        ),
      ],
    );
  }
}
