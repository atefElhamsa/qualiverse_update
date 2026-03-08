import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class AccreditationStructureContent extends StatelessWidget {
  const AccreditationStructureContent({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FirstPartAccreditationStructure(),
            SizedBox(height: 24),
            EvidencePerCriterionChart(),
          ],
        ),
      ),
    );
  }
}
