import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AnalysisFilesBody extends StatelessWidget {
  const AnalysisFilesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const CustomScaffold(
      widget: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnalysisFilesTopAndTitle(),
          AnalysisFilesNewButton(),
          SizedBox(height: 20),
          EvidenceFoldersList(),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}
