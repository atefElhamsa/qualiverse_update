import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class StatisticsPreviewHeader extends StatelessWidget {
  final VoidCallback onClose;
  const StatisticsPreviewHeader({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(30.w, 30.h, 30.w, 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.progressColor,
                  AppColors.progressColor.withOpacity(0.7),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.progressColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(Icons.auto_graph_rounded, color: Colors.white, size: 26.sp),
          ),
          SizedBox(width: 20.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "previewResults".tr(),
                style: GoogleFonts.almarai(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                  color: const Color(0xFF1E293B),
                ),
              ),
              Text(
                "reviewMatchesBeforeConfirming".tr(),
                style: GoogleFonts.almarai(
                  fontSize: 13.sp,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
          const Spacer(),
          IconButton(
            onPressed: onClose,
            icon: Icon(
              Icons.close_rounded,
              color: Colors.grey.shade400,
              size: 28.sp,
            ),
          ),
        ],
      ),
    );
  }
}
