import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_card.dart';

class TotalStudentsCard extends StatelessWidget {
  final int count;
  const TotalStudentsCard({super.key, required this.count});

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: "totalStudents".tr(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.people_alt_rounded,
            color: const Color(0xFF4285F4),
            size: 40.sp,
          ),
          SizedBox(width: 15.w),
          Text(
            "$count",
            style: GoogleFonts.almarai(
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF1A1A1A),
            ),
          ),
        ],
      ),
    );
  }
}
