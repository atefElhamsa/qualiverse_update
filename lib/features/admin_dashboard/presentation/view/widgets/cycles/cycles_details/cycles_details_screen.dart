import 'package:flutter/material.dart';

import '../../../../../../../routing/all_routes_imports.dart';

class CyclesDetailsScreen extends StatelessWidget {
  const CyclesDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CyclesDetailsTopWidget(),
          SizedBox(height: 20),
          CyclesDetailsTapsWidget(),
          CycleDetailsTapsContent(),
        ],
      ),
    );
  }
}
