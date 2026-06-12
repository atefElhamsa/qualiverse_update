import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class ChangeAndCancelButtons extends StatelessWidget {
  const ChangeAndCancelButtons({super.key, required this.changePasswordCubit});

  final ChangePasswordCubit changePasswordCubit;

  @override
  Widget build(BuildContext context) {
    final isLight = Theme.of(context).scaffoldBackgroundColor == AppColors.white;
    final isLoading = changePasswordCubit.state is ChangePasswordLoading;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Cancel Button (Outlined for visual hierarchy)
        SizedBox(
          width: 140.w,
          height: 44.h,
          child: OutlinedButton(
            onPressed: isLoading ? null : () => context.pop(),
            style: OutlinedButton.styleFrom(
              side: BorderSide(
                color: isLight
                    ? AppColors.greyLight.withOpacity(0.5)
                    : AppColors.textFieldDark,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: Text(
              "cancel".tr(),
              style: GoogleFonts.inter(
                fontSize: 15.sp,
                fontWeight: FontWeight.w600,
                color: isLight ? AppColors.textGrey : AppColors.greyLight,
              ),
            ),
          ),
        ),
        SizedBox(width: 16.w),
        // Change Button (Primary Blue)
        SizedBox(
          width: 140.w,
          height: 44.h,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => changePasswordCubit.changePasswordCubit(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.blue,
              disabledBackgroundColor: AppColors.blue.withOpacity(0.6),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_rounded,
                        size: 16.r,
                        color: Colors.white,
                      ),
                      SizedBox(width: 6.w),
                      Text(
                        "change".tr(),
                        style: GoogleFonts.inter(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ],
    );
  }
}
