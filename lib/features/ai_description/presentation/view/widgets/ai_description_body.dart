import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/routing/app_routes.dart';

class AiDescriptionBody extends StatefulWidget {
  const AiDescriptionBody({super.key});

  @override
  State<AiDescriptionBody> createState() => _AiDescriptionBodyState();
}

class _AiDescriptionBodyState extends State<AiDescriptionBody> {
  List<File?> uploadedFilesSpecification = List<File?>.filled(
    2,
    null,
    growable: false,
  );

  final int maxFiles = 2;

  int countUploadedFileDone = 0;
  double get progress {
    if (uploadedFilesSpecification.isEmpty) return 0;
    return countUploadedFileDone / maxFiles;
  }

  Future<void> pickFile(int index) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null && result.files.single.path != null) {
      setState(() {
        uploadedFilesSpecification[index] = File(result.files.single.path!);
        countUploadedFileDone++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<FileItemModel> fileItemModels = [
      FileItemModel(
        titleFile: "equivalentCourses",
        aboutFile: "courseSynonyms".tr(),
        onTap: () => pickFile(0),
        file: uploadedFilesSpecification[0],
      ),
      FileItemModel(
        titleFile: "stampFile",
        aboutFile: "basicSentence".tr(),
        onTap: () => pickFile(1),
        file: uploadedFilesSpecification[1],
      ),
    ];
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AiDescriptionTop(),
          Padding(
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
                      "youMustUploadTwoFilesInPdfWordTypeOnly".tr(),
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
          ),
          const SizedBox(height: 8),
          // Upload Area
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 30.w),
            child: ListFileItemWidget(fileItemModels: fileItemModels),
          ),
          const SizedBox(height: 12),
          // Compact Floating Action Bar
          Padding(
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
                      Expanded(
                        child: StartEndNumberFileCompleted(
                          countUploadedFileDone: countUploadedFileDone,
                          maxFiles: maxFiles,
                        ),
                      ),
                      const SizedBox(width: 20),
                      EditApprovedButtons(
                        onApprovedPressed: () {
                          context.push(AppRoutes.aiDescriptionResultScreen);
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  LinearProgressWidget(value: progress),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
