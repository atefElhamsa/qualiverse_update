import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class InstitutionalAccreditationBody extends StatelessWidget {
  const InstitutionalAccreditationBody({super.key});

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
              title: AppTexts.institutionalAccreditationEnglish,
              textStyle: Theme.of(context).textTheme.displayLarge!,
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: CustomText(
              title: AppTexts.institutionalAccreditationArabic,
              textStyle: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(fontSize: 32.sp),
            ),
          ),
          const SizedBox(height: 10),
          const SelectYear(),
          const SizedBox(height: 30),
          const GridViewInstitutionalItemsWidget(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
