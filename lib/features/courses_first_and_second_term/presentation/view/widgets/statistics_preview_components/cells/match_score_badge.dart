import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class MatchScoreBadge extends StatelessWidget {
  final int score;
  const MatchScoreBadge({super.key, required this.score});

  @override
  Widget build(BuildContext context) {
    final color = _getScoreColor(score);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Text(
        "${score}%",
        style: GoogleFonts.almarai(
          fontSize: 12.sp,
          fontWeight: FontWeight.w800,
          color: color,
        ),
      ),
    );
  }

  Color _getScoreColor(int score) {
    if (score >= 90) return const Color(0xFF10B981);
    if (score >= 70) return const Color(0xFF3B82F6);
    if (score >= 50) return const Color(0xFFF59E0B);
    return const Color(0xFFEF4444);
  }
}
