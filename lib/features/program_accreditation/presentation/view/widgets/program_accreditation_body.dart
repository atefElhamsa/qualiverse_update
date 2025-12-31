import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ProgramAccreditationBody extends StatelessWidget {
  const ProgramAccreditationBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomScaffoldTop(controller: inherited.controller),
          Center(
            child: CustomText(
              title: AppTexts.softwareAccreditationEnglish,
              textStyle: Theme.of(context).textTheme.displayLarge!,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: CustomText(
              title: AppTexts.softwareAccreditationArabic,
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 32.sp),
            ),
          ),
          const SizedBox(height: 30),
          const GridViewProgramItemsWidget(),
        ],
      ),
    );
  }
}
