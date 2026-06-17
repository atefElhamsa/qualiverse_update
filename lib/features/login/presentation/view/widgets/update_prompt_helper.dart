import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';
import 'package:qualiverse/routing/app_routes.dart';

class UpdatePromptHelper {
  static Future<void> checkUpdateAndPrompt(BuildContext context) async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    String? savedVersion = CashHelper.getData(key: KeysTexts.appVersion);

    if (LoginStorage.hasToken &&
        savedVersion != null &&
        savedVersion != currentVersion) {
      bool? shouldContinue = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.r),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          child: Container(
            width: 400.w,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color:
                  Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? Colors.white
                  : AppColors.mainBlack,
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: AppColors.blue.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.update_rounded,
                    color: AppColors.blue,
                    size: 40.w,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'updateDetected'.tr(),
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 12.h),
                Text(
                  'continueWithSameAccount'.tr(),
                  style: TextStyle(fontSize: 14.sp, color: AppColors.mainGrey),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: OutlinedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          side: BorderSide(
                            color: AppColors.mainGrey.withOpacity(0.5),
                          ),
                        ),
                        child: Text(
                          'no'.tr(),
                          style: TextStyle(
                            color: AppColors.mainGrey,
                            fontSize: 16.sp,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.blue,
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          'yes'.tr(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );

      await CashHelper.saveData(
        key: KeysTexts.appVersion,
        value: currentVersion,
      );

      if (shouldContinue == true) {
        if (context.mounted) context.pushReplacementNamed(AppRoutes.homeScreen);
      } else {
        await LoginStorage.clear();
      }
    }
  }
}
