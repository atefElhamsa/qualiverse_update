import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ListData extends StatefulWidget {
  const ListData({super.key});

  @override
  State<ListData> createState() => _ListDataState();
}

class _ListDataState extends State<ListData> {
  int? selectedYear;

  final List<int> years = [2025, 2026, 2027];

  int? selectedLevel;
  final List<int> levels = [1, 2, 3, 4];

  String? selectedDepartment;
  final List<String> departments = [
    // Localized department names.
    "all".tr(),
    "informationTechnology".tr(),
    "informationSystems".tr(),
  ];

  String? selectedAccreditation;
  final List<String> accreditations = [
    // Localized department names.
    "all".tr(),
    "program".tr(),
    "institutional".tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const CustomContainerDashboard(
          widget: TitleDataWidget(title: "totalCourses", number: "48"),
        ),
        const CustomContainerDashboard(
          widget: TitleDataWidget(title: "totalEvidence", number: "8"),
        ),
        const CustomContainerDashboard(
          widget: TitleDataWidget(title: "totalCriteria", number: "8"),
        ),
        CustomContainerDashboard(
          widget: CustomDropButton(
            dropButtonModel: DropButtonModel(
              selectedData: selectedDepartment,
              listOfData: departments,
              hintText: "department",
              hintSize: 15.sp,
            ),
          ),
        ),
        CustomContainerDashboard(
          widget: CustomDropButton(
            dropButtonModel: DropButtonModel(
              selectedData: selectedAccreditation,
              listOfData: accreditations,
              hintText: "accreditation",
              hintSize: 15.sp,
            ),
          ),
        ),
        CustomContainerDashboard(
          widget: CustomDropButton(
            dropButtonModel: DropButtonModel(
              selectedData: selectedLevel,
              listOfData: levels,
              hintText: "level",
              hintSize: 15.sp,
            ),
          ),
        ),
        CustomContainerDashboard(
          widget: CustomDropButton(
            dropButtonModel: DropButtonModel(
              selectedData: selectedYear,
              listOfData: years,
              hintText: "year",
              hintSize: 15.sp,
            ),
          ),
        ),
      ],
    );
  }
}
