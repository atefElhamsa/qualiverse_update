import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            SizedBox(
              width: 230.w,
              child: CustomText(
                title: "profilePicture".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
              ),
            ),
            Expanded(
              child: Row(
                children: [
                  Image.asset(AppImages.imagePicker),
                  SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: "upload_new_photo".tr(),
                        textStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(fontSize: 16.sp, color: AppColors.black),
                      ),
                      CustomText(
                        title: "click_to_upload".tr(),
                        textStyle: Theme.of(context).textTheme.labelSmall!
                            .copyWith(fontSize: 16.sp, color: AppColors.red),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(thickness: 1, color: AppColors.mainBlack),
        SizedBox(height: 8.h),
      ],
    );
  }
}
