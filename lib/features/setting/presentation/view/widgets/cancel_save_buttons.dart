import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CancelSaveButtons extends StatelessWidget {
  const CancelSaveButtons({
    super.key,
    required this.onSave,
    required this.onCancel,
  });

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 45.h, bottom: 5.h, start: 15.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 72.w,
            height: 58.h,
            child: CustomButton(
              buttonModel: ButtonModel(
                onPressed: onCancel,
                backgroundColor: AppColors.greyLight,
                radius: 14,
                customText: CustomText(
                  title: "cancel".tr(),
                  textStyle: GoogleFonts.cairo(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.grey,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 87.5),
          SizedBox(
            // width: 163.w,
            height: 58.h,
            child: CustomButton(
              buttonModel: ButtonModel(
                space: 10,
                onPressed: onSave,
                backgroundColor: AppColors.colorButtonLight,
                radius: 14,
                customText: CustomText(
                  title: "saveChanges".tr(),
                  textStyle: GoogleFonts.cairo(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                    color: AppColors.sideBarItemDark,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
