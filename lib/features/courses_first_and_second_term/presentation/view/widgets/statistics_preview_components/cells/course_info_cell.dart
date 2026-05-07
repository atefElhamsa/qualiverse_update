import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class CourseInfoCell extends StatelessWidget {
  final String name;
  const CourseInfoCell({super.key, required this.name});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.w,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: GoogleFonts.almarai(
              fontWeight: FontWeight.bold,
              fontSize: 14.sp,
              color: const Color(0xFF1E293B),
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            "fromFile".tr(),
            style: GoogleFonts.almarai(
              fontSize: 11.sp,
              color: Colors.grey.shade400,
            ),
          ),
        ],
      ),
    );
  }
}
