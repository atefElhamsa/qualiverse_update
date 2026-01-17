import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class AiDescriptionBody extends StatefulWidget {
  const AiDescriptionBody({super.key});

  @override
  State<AiDescriptionBody> createState() => _AiDescriptionBodyState();
}

class _AiDescriptionBodyState extends State<AiDescriptionBody> {
  // List to store uploaded files.
  List<File?> uploadedFilesSpecification = List<File?>.filled(
    2,
    null,
    growable: false,
  );

  // Maximum number of files that can be uploaded.
  final int maxFiles = 2;

  // Counter for the number of files that have been uploaded.
  int countUploadedFileDone = 0;

  // Calculate the progress based on the uploaded files.
  double get progress {
    if (uploadedFilesSpecification.isEmpty) return 0;
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
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const AiDescriptionTop(),
          CustomText(
            title: "youMustUploadThreeFilesInPdfWordTypeOnly".tr(),
            textStyle: Theme.of(context).textTheme.labelSmall!,
          ),
          const SizedBox(height: 10),
          // Display the list of file items.
          ListFileItemWidget(fileItemModels: fileItemModels),
          const SizedBox(height: 20),
          // Display the number of uploaded files and buttons.
          StartEndNumberFileCompleted(
            countUploadedFileDone: countUploadedFileDone,
            maxFiles: maxFiles,
          ),
          const SizedBox(height: 10),
          // Display the progress bar.
          LinearProgressWidget(value: progress),
          // Display the buttons for editing and approving.
          const SizedBox(height: 10),
          const EditApprovedButtons(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
