import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class CoursesMainFields extends StatefulWidget {
  CoursesMainFields({
    super.key,
    required this.years,
    required this.departments,
    required this.levels,
    required this.locale,
    required this.selectedYear,
    required this.selectedDepartment,
    required this.selectedLevel,
  });

  int? selectedYear;
  String? selectedDepartment;
  String? selectedLevel;
  final List<int> years;
  final List<String> departments;
  final List<String> levels;
  final Locale locale;

  @override
  State<CoursesMainFields> createState() => _CoursesMainFieldsState();
}

class _CoursesMainFieldsState extends State<CoursesMainFields> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomDropButtonAndTitle(
          dropButtonModel: DropButtonModel(
            selectedData: widget.selectedYear,
            listOfData: widget.years,
            hintText: "selectedYear".tr(),
            hintSize: 20.sp,
            onChanged: (value) {
              setState(() {
                widget.selectedYear = value;
              });
            },
          ),
          title: "year".tr(),
        ),
        CustomDropButtonAndTitle(
          dropButtonModel: DropButtonModel(
            selectedData: widget.selectedLevel,
            listOfData: widget.levels,
            hintText: "chooseStudyLevel".tr(),
            hintSize: 20.sp,
            onChanged: (value) {
              setState(() {
                widget.selectedLevel = value;
              });
            },
          ),
          title: "level".tr(),
        ),
        CustomDropButtonAndTitle(
          dropButtonModel: DropButtonModel(
            selectedData: widget.selectedDepartment,
            listOfData: widget.departments,
            hintText: "selectTheDepartment".tr(),
            hintSize: 20.sp,
            onChanged: (value) {
              setState(() {
                widget.selectedDepartment = value;
              });
            },
          ),
          title: "department".tr(),
        ),
      ],
    );
  }
}
