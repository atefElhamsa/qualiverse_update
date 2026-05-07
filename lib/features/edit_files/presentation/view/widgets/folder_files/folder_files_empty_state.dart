import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class FolderFilesEmptyState extends StatelessWidget {
  const FolderFilesEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.folder_open_rounded,
            size: 64.sp,
            color: AppColors.greyLight.withOpacity(0.5),
          ),
          SizedBox(height: 16.h),
          Text(
            'noFile'.tr(),
            style: GoogleFonts.almarai(
              fontSize: 15.sp,
              color: AppColors.greyLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
