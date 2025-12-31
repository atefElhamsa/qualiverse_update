import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class LoginBottomTitle extends StatelessWidget {
  const LoginBottomTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 5.h, end: 24.w, start: 46.w),
      child: Row(
        children: [
          Image.asset(AppImages.iconLogoSmall),
          const SizedBox(width: 10),
          CustomText(
            title: "accreditationQualitySystem".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.displayLarge!.copyWith(fontSize: 14.sp),
          ),
          const Spacer(),
          SizedBox(
            width: 200.w,
            child: CustomText(
              title: "loginBottomTitle".tr(),
              textAlign: TextAlign.right,
              textStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
                fontSize: 12.sp,
                color: AppColors.greyLight.withOpacity(0.75),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
