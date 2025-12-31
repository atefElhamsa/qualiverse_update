import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class InfoItemWidget extends StatelessWidget {
  const InfoItemWidget({super.key, required this.infoItemModel});

  final InfoItemModel infoItemModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 422.w,
      height: 64.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: AppColors.drInfoColor,
        borderRadius: BorderRadius.circular(22.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            infoItemModel.iconData,
            color: AppColors.drColor,
            fontWeight: FontWeight.bold,
            size: 32.sp,
          ),
          Expanded(
            child: CustomText(
              title: infoItemModel.text,
              textAlign: TextAlign.center,
              textStyle: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.drColor,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
