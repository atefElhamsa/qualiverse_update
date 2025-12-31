import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SelectedYearAndDepartmentWidget extends StatelessWidget {
  const SelectedYearAndDepartmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        SelectedDepartmentWidget(),
        SizedBox(height: 10),
        SelectedAcademicYearWidget(),
      ],
    );
  }
}
