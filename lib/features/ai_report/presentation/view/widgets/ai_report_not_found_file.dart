import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class AiReportNotFoundFile extends StatelessWidget {
  const AiReportNotFoundFile({super.key, required this.titleFile});

  final String titleFile;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 5,
      children: [
        // image upload file
        Image.asset(AppImages.iconUpload, fit: BoxFit.cover),
        CustomText(
          title: "chooseFile".tr(),
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 24.sp,
            color: AppColors.colorButtonLight,
          ),
        ),
        CustomText(
          title: "uploadHint".tr(),
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            fontSize: 21.sp,
            color: AppColors.greyLight,
          ),
        ),
        CustomText(
          title: titleFile.tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!,
        ),
      ],
    );
  }
}
