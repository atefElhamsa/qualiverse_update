import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/evidence_folder_files/evidence_folder_file_item.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_model.dart';

class EvidenceFileList extends StatelessWidget {
  final List<EvidenceFileModel> files;
  final int folderId;

  const EvidenceFileList({
    super.key,
    required this.files,
    this.folderId = -1,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 20.h),
      itemCount: files.length,
      separatorBuilder: (_, __) => SizedBox(height: 10.h),
      itemBuilder: (context, index) {
        return EvidenceFolderFileItem(
          file: files[index],
          isArabic: context.locale.languageCode == 'ar',
          folderId: folderId,
        );
      },
    );
  }
}
