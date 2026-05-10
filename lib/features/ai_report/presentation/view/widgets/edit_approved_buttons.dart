import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/routing/app_routes.dart';

class EditApprovedButtons extends StatelessWidget {
  final VoidCallback? onApprovedPressed;
  const EditApprovedButtons({super.key, this.onApprovedPressed});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onApprovedPressed ??
                () => context.push(AppRoutes.aiDescriptionResultScreen),
            child: Container(
              height: 50.h,
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              decoration: BoxDecoration(
                color: AppColors.colorButtonLight,
                borderRadius: BorderRadius.circular(32.r),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.colorButtonLight.withOpacity(0.3),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                "approved".tr(),
                style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                      color: AppColors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
