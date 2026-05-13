import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/edit_files/presentation/view/widgets/folder_files/folder_upload_button.dart';

class EvidenceFolderToolbar extends StatelessWidget {
  final bool isUploading;
  final VoidCallback onUpload;
  final TextEditingController searchController;
  final Function(String) onSearchChanged;

  const EvidenceFolderToolbar({
    super.key,
    required this.isUploading,
    required this.onUpload,
    required this.searchController,
    required this.onSearchChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          FolderUploadButton(
            isLoading: isUploading,
            onUpload: onUpload,
          ),
          SizedBox(width: 15.w),
          Expanded(
            child: Container(
              height: 42.h,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: TextField(
                controller: searchController,
                onChanged: onSearchChanged,
                decoration: InputDecoration(
                  hintText: 'Search file...',
                  hintStyle: GoogleFonts.almarai(
                      color: Colors.grey.shade400, fontSize: 13.sp),
                  prefixIcon: Icon(Icons.search_rounded,
                      color: Colors.grey.shade400, size: 15.sp),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 8.h),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
