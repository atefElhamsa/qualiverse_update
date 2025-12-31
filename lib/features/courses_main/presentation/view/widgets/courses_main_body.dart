import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

// Define a stateful widget for the main body of the courses screen.
class CoursesMainBody extends StatefulWidget {
  const CoursesMainBody({super.key});

  @override
  State<CoursesMainBody> createState() => _CoursesMainBodyState();
}

// Define the state for the CoursesMainBody widget.
class _CoursesMainBodyState extends State<CoursesMainBody> {
  // Variables to hold the selected year, department, and level.
  int? selectedYear;
  String? selectedDepartment;
  String? selectedLevel;

  // Lists of available years, departments, and levels.
  final List<int> years = [2022, 2023, 2024, 2025];
  final List<String> departments = [
    // Localized department names.
    "computerScience".tr(),
    "informationTechnology".tr(),
    "informationSystems".tr(),
    "artificialIntelligence".tr(),
  ];
  final List<String> levels = [
    // Localized level names.
    "firstLevel".tr(),
    "secondLevel".tr(),
    "thirdLevel".tr(),
    "fourthLevel".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    final isDrawerVisible = inherited.isDrawerVisible;
    // Get the current locale.
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    // Return a custom scaffold containing the UI elements.
    return CustomScaffold(
      widget: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Display the top part of the scaffold.
          !isDrawerVisible
              ? CustomScaffoldTop(controller: inherited.controller)
              : const SizedBox(),
          // Center the "courses" title.
          Center(
            child: CustomText(
              // Localized title.
              title: "courses".tr(),
              textStyle: Theme.of(context).textTheme.displayLarge!.copyWith(
                fontSize: 50.sp,
              ), // Apply custom text style.
            ),
          ),
          CoursesMainDetails(
            selectedYear: selectedYear,
            selectedDepartment: selectedDepartment,
            selectedLevel: selectedLevel,
            years: years,
            departments: departments,
            levels: levels,
            locale: locale,
          ),
        ],
      ),
    );
  }
}
