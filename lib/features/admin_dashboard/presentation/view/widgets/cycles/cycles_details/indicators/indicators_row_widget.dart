import 'package:flutter/material.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

class IndicatorsRowWidget extends StatelessWidget {
  const IndicatorsRowWidget({
    super.key,
    required this.cycleIndicator,
    required this.index,
    required this.total,
  });

  final CycleIndicatorModel cycleIndicator;
  final int index;
  final int total;

  Color get statusColor {
    switch (cycleIndicator.status?.toLowerCase()) {
      case 'pending':
        return AppColors.yellow;
      case 'submitted':
        return AppColors.green;
      case 'approved':
        return AppColors.blue;
      case 'rejected':
        return AppColors.red;
      default:
        return AppColors.transparent;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isSmall = MediaQuery.of(context).size.width < 900;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        isSmall
            ? buildCard(context, cycleIndicator, statusColor)
            : buildRow(context, cycleIndicator, statusColor),
        if (index < total - 1 && !isSmall)
          const Divider(height: 1, thickness: 1, color: AppColors.grey),
      ],
    );
  }
}
