import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_filters_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/dashboard_body.dart';
import 'package:qualiverse/features/department/presentation/controller/academic_year_cubit.dart';
import 'package:qualiverse/features/home/presentation/view/widgets/main_wrapper.dart';
import 'package:qualiverse/features/department/presentation/controller/department_cubit.dart';
import 'package:qualiverse/features/courses_main/presentation/controller/level/level_cubit.dart';
import 'package:qualiverse/features/accreditation/presentation/controller/type_cubit.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DashboardCubit()..getDashboard()),
        BlocProvider(create: (context) => DashboardFiltersCubit()),
        BlocProvider(create: (context) => AcademicYearCubit()..fetchAcademicYears()),
        BlocProvider(create: (context) => DepartmentCubit()..fetchDepartments()),
        BlocProvider(create: (context) => LevelCubit()..fetchLevels()),
        BlocProvider(create: (context) => TypesCubit()..fetchTypes()),
      ],
      child: const MainWrapper(child: DashboardBody()),
    );
  }
}
