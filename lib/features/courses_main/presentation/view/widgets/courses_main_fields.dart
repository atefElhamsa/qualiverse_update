import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class CoursesMainFields extends StatelessWidget {
  const CoursesMainFields({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SelectedAcademicYearWidget(),
        SelectedLevelWidget(),
        SelectedDepartmentWidget(),
      ],
    );
  }
}
