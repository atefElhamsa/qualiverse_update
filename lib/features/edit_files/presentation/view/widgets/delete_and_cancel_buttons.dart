import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class DeleteAndCancelButtons extends StatelessWidget {
  const DeleteAndCancelButtons({
    super.key,
    required this.onPressed,
    this.isLoading = false,
  });

  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        CustomButton(
          buttonModel: ButtonModel(
            onPressed: isLoading ? null : onPressed,
            backgroundColor: AppColors.red,
            radius: 12,
            space: 12.h,
            customText: CustomText(
              title: isLoading ? "" : "delete".tr(),
              textStyle: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        if (isLoading)
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: SizedBox(
              width: 20.w,
              height: 20.w,
              child: const CircularProgressIndicator(
                color: AppColors.red,
                strokeWidth: 2,
              ),
            ),
          ),
        const SizedBox(width: 12),
        CustomButton(
          buttonModel: ButtonModel(
            onPressed: isLoading
                ? null
                : () {
                    context.pop();
                  },
            backgroundColor: const Color(0xFFE5E7EB),
            radius: 12,
            space: 12.h,
            customText: CustomText(
              title: "cancel".tr(),
              textStyle: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.mainBlack,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
