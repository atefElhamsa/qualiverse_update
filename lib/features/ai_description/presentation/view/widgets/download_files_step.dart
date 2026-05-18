import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';


class DownloadFilesStep extends StatelessWidget {
  const DownloadFilesStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiDescriptionCubit, AiDescriptionState>(
      builder: (context, state) {
        final cubit = context.read<AiDescriptionCubit>();

        return Column(
          children: [
            SizedBox(height: 5.h),
            _buildHeader(),
            SizedBox(height: 15.h),
            DownloadFilesStepBody(
              cubit: cubit,
              onEdit: () => _handleEdit(context, cubit),
              onDownload: () => _handleDownload(context, cubit),
            ),
          ],
        );
      },
    );
  }

  Widget _buildHeader() {
    return Text(
      "downloadFiles".tr(),
      style: GoogleFonts.almarai(
        fontSize: 32.sp,
        fontWeight: FontWeight.w800,
        color: AppColors.aiTitle,
        letterSpacing: -0.8,
      ),
    );
  }

  // --- Logic Handlers ---

  Future<void> _handleEdit(
    BuildContext context,
    AiDescriptionCubit cubit,
  ) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: true,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx'],
    );

    if (!context.mounted) return;

    if (result != null && result.files.length >= 2) {
      File? docx;
      File? pdf;

      for (var file in result.files) {
        if (file.extension == 'docx') docx = File(file.path!);
        if (file.extension == 'pdf') pdf = File(file.path!);
      }

      if (docx != null && pdf != null) {
        cubit.selectCustomFiles(docx: docx, pdf: pdf);
      } else {
        showSnackBar(context, "pleaseSelectBothFiles".tr(), AppColors.red);
      }
    } else {
      showSnackBar(context, "pleaseSelectBothFiles".tr(), AppColors.red);
    }
  }

  Future<void> _handleDownload(
    BuildContext context,
    AiDescriptionCubit cubit,
  ) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => DownloadOptionsSheet(cubit: cubit),
    );
  }
}
