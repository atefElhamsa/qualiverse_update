import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class CreateIndicatorsButton extends StatelessWidget {
  const CreateIndicatorsButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: SizedBox(
        height: 45.h,
        child: FilledButton.icon(
          onPressed: () {},
          style: FilledButton.styleFrom(
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.all(5),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),
            ),
          ),
          icon: const Icon(Icons.add, size: 25),
          label: CustomText(
            title: 'Create Indicators',
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
