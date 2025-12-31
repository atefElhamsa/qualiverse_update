import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ProgramAccreditationScreen extends StatelessWidget {
  const ProgramAccreditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final data = GoRouterState.of(context).extra as Map<String, dynamic>;

    final academicYearId = data['academicYearId'] as int;
    final departmentId = data['departmentId'] as int?;
    return BlocProvider(
      create: (context) => ProgramAccreditationCubit()
        ..fetchProgramAccreditations(
          academicYearId: academicYearId,
          departmentId: departmentId,
        ),
      child: const MainWrapper(child: ProgramAccreditationBody()),
    );
  }
}
