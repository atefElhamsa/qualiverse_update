import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
            radius: 20,
            space: 10.h,
            customText: CustomText(
              title: isLoading ? "" : "delete".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 20.sp,
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
        const SizedBox(width: 10),
        CustomButton(
          buttonModel: ButtonModel(
            onPressed: isLoading
                ? null
                : () {
                    context.pop();
                  },
            backgroundColor: AppColors.green,
            radius: 20,
            space: 10.h,
            customText: CustomText(
              title: "cancel".tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
