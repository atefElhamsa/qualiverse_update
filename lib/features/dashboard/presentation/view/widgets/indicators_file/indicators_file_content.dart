import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class IndicatorsFileContent extends StatelessWidget {
  const IndicatorsFileContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocProvider(
        create: (_) => DocumentsCubit()..loadDocuments(),
        child: const DocumentsPage(),
      ),
    );
  }
}
