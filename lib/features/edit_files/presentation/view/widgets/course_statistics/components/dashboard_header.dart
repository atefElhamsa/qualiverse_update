import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/edit_files/data/models/get_file_data_model.dart';

class DashboardHeader extends StatelessWidget {
  final GetFileDataModel data;
  const DashboardHeader({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF0F569E);
    
    return Center(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(color: primaryColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: primaryColor.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              data.courseName,
              textAlign: TextAlign.center,
              style: GoogleFonts.cairo(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: primaryColor,
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 4.h),
              height: 1.h,
              width: 200.w,
              color: primaryColor.withOpacity(0.3),
            ),
            Text(
              "COURSE STATISTICS - ACADEMIC YEAR ${data.academicYearNumber}",
              style: GoogleFonts.cairo(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
