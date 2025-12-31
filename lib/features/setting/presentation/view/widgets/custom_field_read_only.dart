import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CustomFieldReadOnly extends StatelessWidget {
  const CustomFieldReadOnly({
    super.key,
    required this.title,
    required this.data,
    this.obscureText,
  });

  final String title;
  final String data;
  final bool? obscureText;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 592.w,
      child: ListTile(
        title: Padding(
          padding: const EdgeInsets.only(bottom: 3),
          child: CustomText(
            title: title,
            textStyle: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500,
              color: AppColors.mainBlack,
            ),
          ),
        ),
        subtitle: TextFormField(
          readOnly: true,
          obscureText: obscureText ?? false,
          obscuringCharacter: '*',
          initialValue: data,
          style: GoogleFonts.inter(
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.drColor,
          ),
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.tableColor,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }
}
