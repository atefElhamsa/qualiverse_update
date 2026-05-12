import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_report/data/models/file_item_model.dart';
import 'package:qualiverse/features/ai_report/presentation/view/widgets/file_item_widget.dart';

class AiDescriptionFileUploadSection extends StatelessWidget {
  final VoidCallback onPickProgram;
  final VoidCallback onPickTemplate;
  final File? programFile;
  final File? templateFile;

  const AiDescriptionFileUploadSection({
    super.key,
    required this.onPickProgram,
    required this.onPickTemplate,
    this.programFile,
    this.templateFile,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          FileItemWidget(
            fileItemModel: FileItemModel(
              titleFile: "${"programFile".tr()} *",
              aboutFile: "courseSynonyms".tr(),
              onTap: onPickProgram,
              file: programFile,
            ),
          ),
          SizedBox(width: 20.w),
          FileItemWidget(
            fileItemModel: FileItemModel(
              titleFile: "${"templateFile".tr()} *",
              aboutFile: "basicSentence".tr(),
              onTap: onPickTemplate,
              file: templateFile,
            ),
          ),
        ],
      ),
    );
  }
}
