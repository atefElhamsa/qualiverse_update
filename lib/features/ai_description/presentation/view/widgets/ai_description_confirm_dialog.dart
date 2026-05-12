import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiDescriptionConfirmDialog extends StatelessWidget {
  final VoidCallback onConfirm;

  const AiDescriptionConfirmDialog({super.key, required this.onConfirm});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      title: Text(
        "confirmFiles".tr(),
        style: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.colorButtonLight,
        ),
        textAlign: TextAlign.center,
      ),
      content: Text(
        "doYouWantToConfirmTheseFiles".tr(),
        style: TextStyle(fontSize: 14.sp, color: Colors.black.withOpacity(0.7)),
        textAlign: TextAlign.center,
      ),
      actionsPadding: EdgeInsets.only(bottom: 20.h, left: 15.w, right: 15.w),
      actions: [
        Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.grey),
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  "cancel".tr(),
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  onConfirm();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.colorButtonLight,
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  "approved".tr(),
                  style: TextStyle(color: Colors.white, fontSize: 13.sp),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
