import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class ListNotification extends StatelessWidget {
  const ListNotification({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 150.h),
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 34.w, vertical: 19.h),
        decoration: BoxDecoration(
          color: AppColors.customContainerSettingColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(45.r),
            bottomRight: Radius.circular(23.r),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 20,
          children: [
            CustomText(
              title: "myUpdates".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.displayLarge!.copyWith(fontSize: 40.sp),
            ),
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return NotificationItemWidget();
                },
                separatorBuilder: (context, index) => SizedBox(height: 32.h),
                itemCount: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
