import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildHeaderFileGeneral extends StatelessWidget {
  const BuildHeaderFileGeneral({
    super.key,
    required this.folderName,
    required this.count,
  });
  final String folderName;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F1FF),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: const Color(0xFF4285F4),
                  size: 13.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: const Color(0xFF0F569E),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.folder_open_rounded,
              color: Colors.white,
              size: 22.sp,
            ),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                folderName.tr(),
                style: GoogleFonts.almarai(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF1A1A1A),
                ),
              ),
              Text(
                '$count ${'files'.tr()}',
                style: GoogleFonts.almarai(
                  fontSize: 13.sp,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}