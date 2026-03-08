import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CoursesPerDepartmentChart extends StatelessWidget {
  const CoursesPerDepartmentChart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CoursesPerDepartmentCubit()..loadData(),
      child: const CoursesPerDepartmentView(),
    );
  }
}
