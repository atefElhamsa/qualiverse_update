import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/edit_files/data/models/file_model.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/folder_files/folder_file_item.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/folder_files/folder_files_empty_state.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/folder_files/folder_upload_button.dart';

class FolderFilesHeader extends StatelessWidget {
  final String folderName;
  final int? fileCount;

  const FolderFilesHeader({
    super.key,
    required this.folderName,
    this.fileCount,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 40.w,
                height: 40.h,
                decoration: BoxDecoration(
                  color: AppColors.progressColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  isArabic ? Icons.arrow_forward_ios : Icons.arrow_back_ios,
                  color: AppColors.progressColor,
                  size: 15.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 14.w),
          Container(
            width: 44.w,
            height: 44.h,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  AppColors.itemContainerColorEdit1,
                  AppColors.itemContainerColorEdit2,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(
              Icons.folder_open_rounded,
              color: Colors.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  folderName,
                  style: GoogleFonts.almarai(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).textTheme.titleLarge?.color,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                if (fileCount != null)
                  Text(
                    '$fileCount ${'files'.tr()}',
                    style: GoogleFonts.almarai(
                      fontSize: 13.sp,
                      color: AppColors.greyLight,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FolderFilesToolbar extends StatelessWidget {
  final VoidCallback onUpload;
  final bool isUploading;
  final TextEditingController searchController;

  const FolderFilesToolbar({
    super.key,
    required this.onUpload,
    required this.searchController,
    this.isUploading = false,
  });

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          FolderUploadButton(onUpload: onUpload, isLoading: isUploading),
          SizedBox(width: 12.w),
          Expanded(
            child: Container(
              height: 46.h,
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: AppColors.greyLight.withOpacity(0.3)),
              ),
              child: TextField(
                controller: searchController,
                textAlign: isArabic ? TextAlign.right : TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'searchFile'.tr(),
                  hintStyle: GoogleFonts.almarai(
                    color: AppColors.greyLight,
                    fontSize: 15.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search,
                    color: AppColors.greyLight,
                    size: 20.sp,
                  ),
                  suffixIcon: ValueListenableBuilder(
                    valueListenable: searchController,
                    builder: (_, value, __) => value.text.isEmpty
                        ? const SizedBox.shrink()
                        : IconButton(
                            icon: Icon(
                              Icons.close,
                              size: 15.sp,
                              color: AppColors.greyLight,
                            ),
                            onPressed: () => searchController.clear(),
                          ),
                  ),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 12.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FolderFilesList extends StatelessWidget {
  final List<FileModel> files;
  final bool isArabic;
  final int folderId;

  const FolderFilesList({
    super.key,
    required this.files,
    required this.isArabic,
    required this.folderId,
  });

  @override
  Widget build(BuildContext context) {
    if (files.isEmpty) return const FolderFilesEmptyState();

    return ListView.separated(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      itemCount: files.length,
      separatorBuilder: (_, _) => SizedBox(height: 10.h),
      itemBuilder: (_, index) => FolderFileItem(
        file: files[index],
        isArabic: isArabic,
        folderId: folderId,
      ),
    );
  }
}
