import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BaseCard extends StatelessWidget {
  final String title;
  final Widget child;

  const BaseCard({super.key, required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.grey.shade200),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildHeader(),
          Padding(padding: EdgeInsets.all(15.w), child: child),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFF),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Center(
        child: Text(
          title,
          style: GoogleFonts.almarai(
            fontSize: 13.sp,
            fontWeight: FontWeight.bold,
            color: const Color(0xFF0F569E),
          ),
        ),
      ),
    );
  }
}
