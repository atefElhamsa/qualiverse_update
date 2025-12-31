import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// A stateless widget that represents the body of the department screen
class DepartmentBody extends StatelessWidget {
  // Constructor for the DepartmentBody widget
  const DepartmentBody({super.key});

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomScaffoldTop(controller: inherited.controller),
          const SizedBox(height: 10),
          Center(
            child: CustomText(
              title: "SelectTheDepartmentAndAcademicYear".tr(),
              textStyle: Theme.of(context).textTheme.labelLarge!,
            ),
          ),
          // Display department body details
          const DepartmentBodyDetails(),
        ],
      ),
    );
  }
}
