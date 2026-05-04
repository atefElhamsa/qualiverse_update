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
      case 'approved':
        return const Color(0xFF10B981); // Green
      case 'pending':
        return const Color(0xFFF59E0B); // Orange
      case 'submitted':
        return const Color(0xFF3B82F6); // Blue
      case 'rejected':
        return const Color(0xFFEF4444); // Red
      default:
        return AppColors.mainGrey;
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
