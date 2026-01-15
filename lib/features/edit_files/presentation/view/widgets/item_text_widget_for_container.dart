import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../routing/all_routes_imports.dart';

class ItemTextWidgetForContainer extends StatelessWidget {
  const ItemTextWidgetForContainer({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return Container(
      width: 357.w,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      constraints: BoxConstraints(minHeight: 56.h),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Container(
            width: 38.w,
            height: 38.h,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.itemContainerColorEdit1,
                  AppColors.itemContainerColorEdit2,
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Center(
              child: Icon(
                Icons.folder_open_rounded,
                color: AppColors.white,
                size: 30.sp,
              ),
            ),
          ),
          const SizedBox(width: 30),
          Expanded(
            child: Text(
              title.tr(),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.cairo(
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.mainBlack,
                height: 1.25,
              ),
            ),
          ),
          EditDeleteDownloadList(),
        ],
      ),
    );
  }
}

// Row(
// children: [
// Container(
// width: 38.w,
// height: 38.h,
// decoration: BoxDecoration(
// gradient: LinearGradient(
// colors: [
// AppColors.itemContainerColorEdit1,
// AppColors.itemContainerColorEdit2,
// ],
// begin: Alignment.centerLeft,
// end: Alignment.centerRight,
// ),
// borderRadius: BorderRadius.circular(8.r),
// ),
// child: Center(
// child: Icon(
// Icons.folder_open_rounded,
// color: AppColors.white,
// size: 30.sp,
// ),
// ),
// ),
// const SizedBox(width: 8),
// Expanded(
// child: Text(
// title.tr(),
// maxLines: 2,
// overflow: TextOverflow.ellipsis,
// style: GoogleFonts.cairo(
// fontSize: 18.sp,
// fontWeight: FontWeight.w500,
// color: AppColors.mainBlack,
// height: 1.25,
// ),
// ),
// ),
// EditDeleteDownloadList(),
// ],
// )
