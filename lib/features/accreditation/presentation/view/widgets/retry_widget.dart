import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class RetryWidget extends StatelessWidget {
  const RetryWidget({super.key, required this.title, this.onPressed});

  final String title;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          CustomText(
            title: title,
            textStyle: GoogleFonts.cairo(
              fontSize: 20.sp,
              color: AppColors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(
              Icons.refresh_rounded,
              size: 30.sp,
              color: AppColors.red,
            ),
          ),
        ],
      ),
    );
  }
}
