import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class BuildToolbarFileGeneral extends StatelessWidget {
  const BuildToolbarFileGeneral({
    super.key,
    required this.isUploading,
    required this.searchController,
    required this.pickAndUpload,
  });
  final bool isUploading;
  final TextEditingController searchController;
  final Future<void> Function() pickAndUpload;

  @override
  Widget build(BuildContext context) {
    final cubit = EvidenceFolderFilesCubit.get(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          GestureDetector(
            onTap: isUploading ? null : pickAndUpload,
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                height: 42.h,
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Row(
                  children: [
                    isUploading
                        ? SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : Icon(
                            Icons.upload_file_rounded,
                            color: Colors.white,
                            size: 15.sp,
                          ),
                    SizedBox(width: 8.w),
                    Text(
                      'uploadFile'.tr(),
                      style: GoogleFonts.almarai(
                        color: Colors.white,
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                onChanged: (v) => cubit.searchFiles(v),
                decoration: InputDecoration(
                  hintText: 'searchFile'.tr(),
                  hintStyle: GoogleFonts.almarai(
                    color: Colors.grey.shade400,
                    fontSize: 13.sp,
                  ),
                  prefixIcon: Icon(
                    Icons.search_rounded,
                    color: Colors.grey.shade400,
                    size: 15.sp,
                  ),
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
