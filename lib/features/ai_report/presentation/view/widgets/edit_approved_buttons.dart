import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class EditApprovedButtons extends StatelessWidget {
  const EditApprovedButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        SizedBox(
          width: 144.w,
          height: 48.h,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {},
              backgroundColor: AppColors.colorButtonLight,
              radius: 32,
              customText: CustomText(
                title: "approved".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
