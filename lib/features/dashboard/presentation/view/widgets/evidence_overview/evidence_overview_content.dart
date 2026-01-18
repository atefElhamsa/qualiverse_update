import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceOverviewContent extends StatelessWidget {
  const EvidenceOverviewContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FirstPartEvidenceOverview(),
            const SizedBox(height: 24),
            Image.asset(
              AppImages.evidenceOverview2,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
