import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/documents/documents_cubit.dart';
import 'documents_page.dart';

class IndicatorsFileContent extends StatelessWidget {
  const IndicatorsFileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DashboardCubit, DashboardState>(
      builder: (context, state) {
        if (state is! DashboardSuccess) {
          return const Center(child: CircularProgressIndicator());
        }
        
        return BlocProvider(
          create: (context) => DocumentsCubit()..loadDocuments(),
          child: const DocumentsPage(),
        );
      },
    );
  }
}
