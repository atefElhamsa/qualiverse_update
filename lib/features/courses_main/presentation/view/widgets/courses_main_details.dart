import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesMainDetails extends StatelessWidget {
  CoursesMainDetails({
    super.key,
    required this.selectedYear,
    required this.selectedDepartment,
    required this.selectedLevel,
    required this.years,
    required this.departments,
    required this.levels,
    required this.locale,
  });

  int? selectedYear;
  String? selectedDepartment;
  String? selectedLevel;
  final List<int> years;
  final List<String> departments;
  final List<String> levels;
  final Locale locale;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 2,
              child: CoursesMainFields(
                years: years,
                departments: departments,
                levels: levels,
                locale: locale,
                selectedYear: selectedYear,
                selectedDepartment: selectedDepartment,
                selectedLevel: selectedLevel,
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(top: 40.h),
                  child: Image.asset(
                    AppImages.accreditationImage,
                    width: 447.w,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              ),
            ),
          ],
        ),
        CoursesMainButton(locale: locale),
      ],
    );
  }
}
