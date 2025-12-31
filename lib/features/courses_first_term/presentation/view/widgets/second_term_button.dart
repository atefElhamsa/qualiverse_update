import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class FirstAndSecondTermButton extends StatelessWidget {
  const FirstAndSecondTermButton({
    super.key,
    required this.title,
    this.mainAxisAlignment,
    this.onPressed,
  });

  final String title;
  final MainAxisAlignment? mainAxisAlignment;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.end,
      children: [
        SizedBox(
          height: 48.h,
          width: 150.w,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: onPressed,
              backgroundColor: AppColors.scaffoldLight1,
              radius: 32,
              customText: CustomText(
                title: title.tr(),
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
