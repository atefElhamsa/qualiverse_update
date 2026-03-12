import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class CoursesButtonsBottom extends StatelessWidget {
  const CoursesButtonsBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: [
          SizedBox(
            height: 60.h,
            child: CustomButton(
              buttonModel: ButtonModel(
                onPressed: () {},
                backgroundColor: AppColors.scaffoldLight1,
                radius: 32,
                customText: CustomText(
                  title: "programReport".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          SizedBox(
            height: 60.h,
            child: CustomButton(
              buttonModel: ButtonModel(
                onPressed: () {},
                backgroundColor: AppColors.colorButtonLight,
                radius: 32,
                customText: CustomText(
                  title: "programDescription".tr(),
                  textStyle: Theme.of(
                    context,
                  ).textTheme.labelSmall!.copyWith(color: AppColors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
