import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class StartEndNumberFileCompleted extends StatefulWidget {
  StartEndNumberFileCompleted({
    super.key,
    required this.countUploadedFileDone,
    required this.maxFiles,
  });

  // Counter for the number of files that have been uploaded.
  int countUploadedFileDone;

  // Maximum number of files that can be uploaded.
  int maxFiles;

  @override
  State<StartEndNumberFileCompleted> createState() =>
      _StartEndNumberFileCompletedState();
}

class _StartEndNumberFileCompletedState
    extends State<StartEndNumberFileCompleted> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // Start and end buttons
        SizedBox(
          width: 100.w,
          height: 48.h,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {},
              backgroundColor: AppColors.greyLight,
              radius: 32,
              customText: CustomText(
                title: "end".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 144.w,
          height: 48.h,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {},
              backgroundColor: AppColors.colorButtonLight,
              radius: 32,
              customText: CustomText(
                title: "start".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
        const Spacer(),
        // Number of files completed
        Row(
          children: [
            CustomText(
              title: "${widget.countUploadedFileDone} / ${widget.maxFiles}",
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
            ),
            const SizedBox(width: 10),
            CustomText(
              title: "indicatorsCompleted".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 24.sp),
            ),
          ],
        ),
      ],
    );
  }
}
