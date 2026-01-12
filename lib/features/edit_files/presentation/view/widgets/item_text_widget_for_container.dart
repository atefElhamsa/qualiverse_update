import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class ItemTextWidgetForContainer extends StatelessWidget {
  const ItemTextWidgetForContainer({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 221.w,
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
      constraints: BoxConstraints(minHeight: 56.h),
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Icon(Icons.folder, color: AppColors.colorButtonLight, size: 24.sp),
          const SizedBox(width: 8),
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
          Icon(Icons.more_vert, size: 20.sp, color: AppColors.mainBlack),
        ],
      ),
    );
  }
}
