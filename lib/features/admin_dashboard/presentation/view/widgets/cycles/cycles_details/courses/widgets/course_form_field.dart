import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/all_core_imports/all_core_imports.dart';

Widget buildFormField({
  required String label,
  required String hint,
  required TextEditingController controller,
  int maxLines = 1,
  double? height,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      buildLabel(label),
      SizedBox(height: 8.h),
      Container(
        height: height ?? 45.h,
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: maxLines > 1 ? 8.h : 0),
        decoration: BoxDecoration(
          border: Border.all(
            color: AppColors.blue.withOpacity(0.2),
            width: 1.2,
          ),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: TextField(
          controller: controller,
          maxLines: maxLines,
          style: TextStyle(fontSize: 15.sp, color: AppColors.mainBlack),
          decoration: InputDecoration(
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: hint,
            hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.greyLight),
            border: InputBorder.none,
            isDense: true,
          ),
        ),
      ),
    ],
  );
}

Widget buildLabel(String label) {
  return RichText(
    text: TextSpan(
      text: '$label ',
      style: TextStyle(
        fontSize: 15.sp,
        color: AppColors.mainBlack,
        fontWeight: FontWeight.w600,
      ),
      children: [
        TextSpan(
          text: '*',
          style: TextStyle(color: AppColors.red, fontSize: 15.sp),
        ),
      ],
    ),
  );
}
