import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class CourseSelectionCell extends StatelessWidget {
  final int? currentSelectedId;
  final List<CourseModel> availableCourses;
  final bool isMatched;
  final Function(int?) onChanged;

  const CourseSelectionCell({
    super.key,
    required this.currentSelectedId,
    required this.availableCourses,
    required this.isMatched,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 380.w,
      margin: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isMatched ? const Color(0xFFE2E8F0) : const Color(0xFFFECACA),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<int>(
          value: availableCourses.any((c) => c.id == currentSelectedId)
              ? currentSelectedId
              : null,
          isExpanded: true,
          padding: EdgeInsets.symmetric(horizontal: 12.w),
          dropdownColor: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          hint: Text(
            "selectCourse".tr(),
            style: GoogleFonts.almarai(
              fontSize: 13.sp,
              color: Colors.grey.shade400,
            ),
          ),
          icon: Icon(
            Icons.arrow_drop_down_circle_outlined,
            color: Colors.grey.shade400,
            size: 20.sp,
          ),
          items: availableCourses.map((course) {
            return DropdownMenuItem<int>(
              value: course.id,
              child: Text(
                course.name,
                style: GoogleFonts.almarai(
                  fontSize: 13.sp,
                  color: const Color(0xFF334155),
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
