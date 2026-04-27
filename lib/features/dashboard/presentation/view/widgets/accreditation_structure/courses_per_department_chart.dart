import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/data/models/department_data_model.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/courses_per_department/courses_per_department_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'courses_per_department_view.dart';

class CoursesPerDepartmentChart extends StatelessWidget {
  const CoursesPerDepartmentChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const CoursesPerDepartmentView();
  }
}
