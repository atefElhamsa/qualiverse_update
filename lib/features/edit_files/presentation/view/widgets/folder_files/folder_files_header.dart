import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class FolderFilesHeader extends StatelessWidget {
  final String folderName;
  final int? fileCount;

  const FolderFilesHeader({super.key, required this.folderName, this.fileCount});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Row(
        children: [
          _buildBackButton(context, isArabic),
          SizedBox(width: 14.w),
          _buildIcon(),
          SizedBox(width: 12.w),
          _buildTitle(context),
        ],
      ),
    );
  }

  Widget _buildBackButton(BuildContext context, bool isArabic) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          width: 40.w, height: 40.h,
          decoration: BoxDecoration(color: AppColors.progressColor.withOpacity(0.12), borderRadius: BorderRadius.circular(10.r)),
          child: Icon(isArabic ? Icons.arrow_forward_ios : Icons.arrow_back_ios, color: AppColors.progressColor, size: 18.sp),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 44.w, height: 44.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(colors: [AppColors.itemContainerColorEdit1, AppColors.itemContainerColorEdit2], begin: Alignment.topLeft, end: Alignment.bottomRight),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(Icons.folder_open_rounded, color: Colors.white, size: 24.sp),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(folderName, style: GoogleFonts.cairo(fontSize: 20.sp, fontWeight: FontWeight.w700, color: Theme.of(context).textTheme.titleLarge?.color), overflow: TextOverflow.ellipsis),
          if (fileCount != null) Text('$fileCount ${'files'.tr()}', style: GoogleFonts.cairo(fontSize: 13.sp, color: AppColors.greyLight)),
        ],
      ),
    );
  }
}
