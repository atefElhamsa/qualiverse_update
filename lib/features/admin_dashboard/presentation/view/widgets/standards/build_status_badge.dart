import 'package:flutter/material.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class BuildStatusBadge extends StatelessWidget {
  final String status;

  const BuildStatusBadge({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final isCompleted = status.toLowerCase() == 'completed';
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: isCompleted
            ? AppColors.completedColor
            : AppColors.inProgressColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: CustomText(
        title: status,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
