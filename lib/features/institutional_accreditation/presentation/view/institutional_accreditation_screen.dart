import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class InstitutionalAccreditationScreen extends StatelessWidget {
  const InstitutionalAccreditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AcademicYearCubit()..fetchAcademicYears(),
        ),
        BlocProvider(create: (context) => InstitutionalAccreditationCubit()),
      ],
      child: const MainWrapper(child: InstitutionalAccreditationBody()),
    );
  }
}
