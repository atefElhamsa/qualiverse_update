import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'base_card.dart';

class AttendanceSummaryCard extends StatelessWidget {
  final int total;
  final int attended;
  final int absent;
  final int absentWithExcuse;
  final int deprived;

  const AttendanceSummaryCard({
    super.key,
    required this.total,
    required this.attended,
    required this.absent,
    required this.absentWithExcuse,
    required this.deprived,
  });

  @override
  Widget build(BuildContext context) {
    return BaseCard(
      title: "ATTENDANCE SUMMARY",
      child: Row(
        children: [
          _buildLeadingIcon(),
          SizedBox(width: 15.w),
          _buildMainStat(),
          const Spacer(),
          _SmallStatBadge(
            label: "ABSENT",
            value: absent,
            bgColor: Colors.red.shade50,
            textColor: Colors.red,
          ),
          SizedBox(width: 8.w),
          _SmallStatBadge(
            label: "EXCUSED",
            value: absentWithExcuse,
            bgColor: Colors.orange.shade50,
            textColor: Colors.orange,
          ),
          SizedBox(width: 8.w),
          _SmallStatBadge(
            label: "DEPRIVED",
            value: deprived,
            bgColor: Colors.grey.shade100,
            textColor: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildLeadingIcon() {
    return Container(
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F1FF),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Icon(
        Icons.check_circle_rounded,
        color: Colors.green,
        size: 30.sp,
      ),
    );
  }

  Widget _buildMainStat() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "ATTENDED EXAM",
          style: GoogleFonts.cairo(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        Text(
          "$attended/$total",
          style: GoogleFonts.cairo(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SmallStatBadge extends StatelessWidget {
  final String label;
  final int value;
  final Color bgColor;
  final Color textColor;

  const _SmallStatBadge({
    required this.label,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          Text(
            label,
            style: GoogleFonts.cairo(
              fontSize: 9.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
          Text(
            "($value)",
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }
}
