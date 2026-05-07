import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../../../core/all_core_imports/all_core_imports.dart';

Widget buildFormField({required String label, required String hint, required TextEditingController controller}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      _buildLabel(label),
      SizedBox(height: 8.h),
      Container(
        height: 45.h, padding: EdgeInsets.symmetric(horizontal: 12.w),
        decoration: BoxDecoration(border: Border.all(color: AppColors.blue.withOpacity(0.2), width: 1.2), borderRadius: BorderRadius.circular(12.r)),
        child: Center(
          child: TextField(
            controller: controller,
            style: TextStyle(fontSize: 15.sp, color: AppColors.mainBlack),
            decoration: InputDecoration(enabledBorder: InputBorder.none, focusedBorder: InputBorder.none, hintText: hint, hintStyle: TextStyle(fontSize: 15.sp, color: AppColors.greyLight), border: InputBorder.none, isDense: true),
          ),
        ),
      ),
    ],
  );
}

Widget _buildLabel(String label) {
  return RichText(
    text: TextSpan(
      text: '$label ',
      style: TextStyle(fontSize: 15.sp, color: AppColors.mainBlack, fontWeight: FontWeight.w600),
      children: [TextSpan(text: '*', style: TextStyle(color: AppColors.red, fontSize: 15.sp))],
    ),
  );
}
