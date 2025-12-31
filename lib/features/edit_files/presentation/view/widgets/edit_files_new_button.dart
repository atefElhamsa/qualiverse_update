import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class EditFilesNewButton extends StatelessWidget {
  const EditFilesNewButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 101.w,
      height: 56.h,
      child: ElevatedButton.icon(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.scaffoldLight1,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.r),
          ),
        ),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add, color: AppColors.white, size: 24.sp),
            const SizedBox(width: 10),
            CustomText(
              title: "new".tr(),
              textStyle: GoogleFonts.cairo(
                fontSize: 18.sp,
                color: AppColors.white,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
