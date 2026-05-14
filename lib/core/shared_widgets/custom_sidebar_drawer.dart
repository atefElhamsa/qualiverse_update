import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CustomSidebarDrawer extends StatelessWidget {
  const CustomSidebarDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return Padding(
      padding: EdgeInsets.only(top: 20.h, bottom: 20.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: CircleAvatar(
              radius: 35.r,
              backgroundImage: const AssetImage(AppImages.logo),
              backgroundColor: Colors.transparent,
            ),
          ),
          SizedBox(height: 12.h),
          CustomText(
            title: "accreditationQualitySystem".tr(),
            textAlign: TextAlign.center,
            textStyle: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w900,
              fontFamily: 'Almarai',
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              "appName".tr(),
              style: TextStyle(
                color: Colors.white70,
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(height: 20.h),
          const Divider(color: Colors.white10, indent: 20, endIndent: 20),
        ],
      ),
    );
  }
}
