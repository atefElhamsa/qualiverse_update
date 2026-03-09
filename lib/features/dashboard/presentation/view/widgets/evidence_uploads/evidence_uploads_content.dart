import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceUploadsContent extends StatelessWidget {
  const EvidenceUploadsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: ChartPage(),
      ),
    );
  }
}
