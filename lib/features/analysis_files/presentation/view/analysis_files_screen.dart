import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class AnalysisFilesScreen extends StatelessWidget {
  const AnalysisFilesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EvidenceFolderCubit()..fetchEvidenceFolders(),
      child: const MainWrapper(child: AnalysisFilesBody()),
    );
  }
}
