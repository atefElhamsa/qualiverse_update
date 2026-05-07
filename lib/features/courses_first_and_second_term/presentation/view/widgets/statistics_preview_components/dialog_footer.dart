import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class DialogFooter extends StatelessWidget {
  final VoidCallback onCancel, onConfirm;
  const DialogFooter({
    super.key,
    required this.onCancel,
    required this.onConfirm,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(30.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(28.r)),
        border: const Border(top: BorderSide(color: Color(0xFFF1F5F9))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton(
            onPressed: onCancel,
            style: TextButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
            ),
            child: Text(
              "cancel".tr(),
              style: GoogleFonts.almarai(
                color: const Color(0xFF64748B),
                fontWeight: FontWeight.bold,
                fontSize: 15.sp,
              ),
            ),
          ),
          SizedBox(width: 20.w),
          ElevatedButton(
            onPressed: onConfirm,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.progressColor,
              padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14.r),
              ),
              elevation: 8,
              shadowColor: AppColors.progressColor.withOpacity(0.4),
            ),
            child: Row(
              children: [
                Text(
                  "confirmUpload".tr(),
                  style: GoogleFonts.almarai(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.sp,
                  ),
                ),
                SizedBox(width: 10.w),
                const Icon(
                  Icons.check_circle_outline_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
