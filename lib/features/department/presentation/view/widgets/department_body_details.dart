import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// Widget to display three buttons in a row.
class DepartmentBodyDetails extends StatelessWidget {
  const DepartmentBodyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    // Center the content.
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DepartmentCubit()..fetchDepartments(),
        ),
        BlocProvider(
          create: (context) => AcademicYearCubit()..fetchAcademicYears(),
        ),
        BlocProvider(create: (context) => ProgramAccreditationCubit()),
      ],
      child: Center(
        // Constrain the width of the content.
        child: SizedBox(
          width: 590.w,
          // Arrange children in a column.
          child: const Column(
            // Align children to the start of the cross axis.
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the selected year and department.
              SelectedYearAndDepartmentWidget(),
              // Add some vertical spacing.
              SizedBox(height: 80),
              // Display the standard button.
              StandardButton(),
              // Add some vertical spacing.
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}
