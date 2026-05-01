import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'folder_upload_button.dart';

class FolderFilesToolbar extends StatelessWidget {
  final VoidCallback onUpload;
  final bool isUploading;
  final TextEditingController searchController;

  const FolderFilesToolbar({super.key, required this.onUpload, required this.searchController, this.isUploading = false});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          FolderUploadButton(onUpload: onUpload, isLoading: isUploading),
          SizedBox(width: 12.w),
          Expanded(child: _buildSearchField(context, isArabic)),
        ],
      ),
    );
  }

  Widget _buildSearchField(BuildContext context, bool isArabic) {
    return Container(
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
          hintStyle: GoogleFonts.cairo(color: AppColors.greyLight, fontSize: 14.sp),
          prefixIcon: Icon(Icons.search, color: AppColors.greyLight, size: 20.sp),
          suffixIcon: _buildClearButton(),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(vertical: 12.h),
        ),
      ),
    );
  }

  Widget? _buildClearButton() {
    return ValueListenableBuilder(
      valueListenable: searchController,
      builder: (_, value, __) => value.text.isEmpty
          ? const SizedBox.shrink()
          : IconButton(icon: Icon(Icons.close, size: 18.sp, color: AppColors.greyLight), onPressed: () => searchController.clear()),
    );
  }
}
