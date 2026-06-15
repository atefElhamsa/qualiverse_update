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
    final meState = context.read<MeCubit>().state;
    final isAdmin = meState is MeSuccess && meState.meModel.role.toLowerCase() == 'admin';
    final typeState = context.read<TypesCubit>().state;
    int? typeId;
    if (typeState is TypesSuccess && typeState.types.isNotEmpty) {
      try {
        typeId = typeState.types
            .firstWhere(
              (t) =>
                  t.name.toLowerCase().contains("program") ||
                  t.name.contains("برامجي"),
            )
            .id;
      } catch (e) {
        // Fallback to second type if not found by name, as Program is usually index 1
        if (typeState.types.length > 1) {
          typeId = typeState.types[1].id;
        }
      }
    }

    return BlocProvider(
      create: (context) =>
          ProgramAccreditationCubit()..fetchProgramAccreditations(
            academicYearId: academicYearId,
            departmentId: departmentId,
            accreditationTypeId: typeId,
            isAdmin: isAdmin,
          ),
      child: MainWrapper(
        child: ProgramAccreditationBody(
          academicYearId: academicYearId,
          departmentId: departmentId,
          typeId: typeId,
          isAdmin: isAdmin,
        ),
      ),
    );
  }
}
