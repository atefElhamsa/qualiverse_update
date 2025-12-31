import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../routing/all_routes_imports.dart';

class SessionDialog {
  static bool _isShowing = false;

  static void showSessionExpired() {
    if (_isShowing) return;
    _isShowing = true;

    final context = RouterGenerator.rootNavigatorKey.currentContext;
    if (context == null) {
      _isShowing = false;
      return;
    }

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        backgroundColor: AppColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.r),
        ),
        title: CustomText(
          title: 'session_expired_title'.tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 24.sp,
            color: AppColors.red,
            fontWeight: FontWeight.w900,
          ),
          textAlign: TextAlign.center,
        ),
        content: CustomText(
          title: 'session_expired_message'.tr(),
          textAlign: TextAlign.center,
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 20.sp,
            color: AppColors.colorButtonLight,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                _isShowing = false;
                Navigator.of(context).pop();
                RouterGenerator.mainRoutingInOurApp.go(AppRoutes.loginScreen);
              },
              backgroundColor: AppColors.loginButtonColor,
              radius: 20,
              space: 10.h,
              customText: CustomText(
                title: 'login'.tr(),
                textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          // TextButton(
          //   onPressed: () {
          //     _isShowing = false;
          //     Navigator.of(context).pop();
          //     RouterGenerator.mainRoutingInOurApp.go(AppRoutes.loginScreen);
          //   },
          //   child: CustomText(
          //     title: 'login'.tr(),
          //     textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
          //       fontSize: 20.sp,
          //       fontWeight: FontWeight.w500,
          //       color: AppColors.colorButtonLight,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
