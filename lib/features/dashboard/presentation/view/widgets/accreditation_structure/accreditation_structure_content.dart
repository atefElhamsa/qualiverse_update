import 'package:flutter/material.dart';

import '../../../../../../routing/all_routes_imports.dart';

class AccreditationStructureContent extends StatelessWidget {
  const AccreditationStructureContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FirstPartAccreditationStructure(),
            const SizedBox(height: 24),
            Image.asset(
              AppImages.accreditationStructure2,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ],
        ),
      ),
    );
  }
}
