import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class EvidenceFolderHeader extends StatelessWidget {
  final String title;
  final int count;
  final IconData icon;
  final Color iconBgColor;

  const EvidenceFolderHeader({
    super.key,
    required this.title,
    required this.count,
    required this.icon,
    this.iconBgColor = const Color(0xFF0F569E),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Container(
                width: 38.w,
                height: 38.h,
                decoration: BoxDecoration(
                  color: const Color(0xFF4285F4).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: const Color(0xFF4285F4), size: 13.sp),
              ),
            ),
          ),
          SizedBox(width: 15.w),
          Container(
            padding: EdgeInsets.all(10.r),
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(icon, color: Colors.white, size: 22.sp),
          ),
          SizedBox(width: 15.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title.tr(),
                  style: GoogleFonts.almarai(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF1A1A1A))),
              if (count != -1)
                Text('$count ${'files'.tr()}',
                    style: GoogleFonts.almarai(
                        fontSize: 13.sp, color: Colors.grey.shade500)),
            ],
          ),
        ],
      ),
    );
  }
}
