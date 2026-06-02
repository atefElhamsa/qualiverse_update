import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/routing/app_routes.dart';

class AiReportBody extends StatefulWidget {
  const AiReportBody({super.key});

  @override
  State<AiReportBody> createState() => _AiReportBodyState();
}

class _AiReportBodyState extends State<AiReportBody> {
  // List to store uploaded files.
  List<File?> uploadedFilesReport = List<File?>.filled(
    3,
    null,
    growable: false,
  );

  // Maximum number of files that can be uploaded.
  final int maxFiles = 3;

  // Counter for the number of files that have been uploaded.
  int countUploadedFileDone = 0;

  // Calculate the progress based on the uploaded files.
  double get progress {
    if (uploadedFilesReport.isEmpty) return 0;
    return countUploadedFileDone / maxFiles;
  }

  // Function to pick a file from the device.
  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        if (uploadedFilesReport[index] == null) {
          countUploadedFileDone++;
        }
        uploadedFilesReport[index] = File(result.files.single.path!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // List of file items to display in the UI.
    final List<FileItemModel> fileItemModels = [
      FileItemModel(
        titleFile: "surveys",
        aboutFile: "",
        onTap: () => pickFile(0),
        file: uploadedFilesReport[0],
      ),
      FileItemModel(
        titleFile: "statistics",
        aboutFile: "",
        onTap: () => pickFile(1),
        file: uploadedFilesReport[1],
      ),
      FileItemModel(
        titleFile: "stampFile",
        aboutFile: "",
        onTap: () => pickFile(2),
        file: uploadedFilesReport[2],
      ),
    ];
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AiReportTop(),
          _buildWarningMessage(context),
          SizedBox(height: 12.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 45.w),
            child: ListFileItemWidget(fileItemModels: fileItemModels),
          ),
          SizedBox(height: 20.h),
          _buildBottomActionBar(context),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }

  Widget _buildWarningMessage(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 45.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.red.withOpacity(0.06),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
          border: Border.all(color: AppColors.red.withOpacity(0.04)),
        ),
        child: Row(
          children: [
            Icon(Icons.info_rounded, color: AppColors.red, size: 20.sp),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                "youMustUploadThreeFilesInPdfWordTypeOnly".tr(),
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  color: AppColors.red.withOpacity(0.8),
                  fontWeight: FontWeight.bold,
                  fontSize: 18.sp,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBottomActionBar(BuildContext context) {
    final isAr = context.locale.languageCode == 'ar';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Completed files status on the left
                Row(
                  children: [
                    CustomText(
                      title: "$countUploadedFileDone / $maxFiles",
                      textStyle: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
                    ),
                    const SizedBox(width: 10),
                    CustomText(
                      title: isAr ? 'ملفات تم رفعها' : 'files completed',
                      textStyle: Theme.of(
                        context,
                      ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
                    ),
                  ],
                ),
                const Spacer(),
                // Approved button on the right
                EditApprovedButtons(
                  onApprovedPressed: () {
                    context.pushNamed(AppRoutes.aiReportResultScreen);
                  },
                ),
              ],
            ),
            SizedBox(height: 10.h),
            LinearProgressWidget(value: progress),
          ],
        ),
      ),
    );
  }
}
