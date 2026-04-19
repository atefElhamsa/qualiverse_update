import 'package:flutter/material.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class IndicatorsTopWidget extends StatelessWidget {
  const IndicatorsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        DepartmentDropDownWidget(),
        SizedBox(width: 24),
        CriterionsDropDownWidget(),
      ],
    );
  }
}
