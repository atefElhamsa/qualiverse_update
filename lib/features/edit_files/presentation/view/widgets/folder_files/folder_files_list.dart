import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/edit_files/data/models/file_model.dart';
import 'folder_file_item.dart';
import 'folder_files_empty_state.dart';

class FolderFilesList extends StatelessWidget {
  final List<FileModel> files;
  final bool isArabic;
  final int folderId;

  const FolderFilesList({super.key, required this.files, required this.isArabic, required this.folderId});

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return const FolderFilesEmptyState();

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: files.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (_, index) => FolderFileItem(file: files[index], isArabic: isArabic, folderId: folderId),
    );
  }
}
