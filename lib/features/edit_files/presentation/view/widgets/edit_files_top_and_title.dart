import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/edit_files/edit_files_imports/edit_files_imports.dart';

class EditFilesTopAndTitle extends StatelessWidget {
  const EditFilesTopAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 240.h,
      child: Stack(
        children: [
          const EditFilesTop(),
          Positioned(
            top: 130.h,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                children: [
                  CustomText(
                    title: "editFiles".tr(),
                    textStyle: Theme.of(
                      context,
                    ).textTheme.displayLarge!.copyWith(fontSize: 50.sp),
                  ),
                  CustomText(
                    title: "manageEvidenceFiles".tr(),
                    textStyle: Theme.of(context).textTheme.headlineLarge!,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
