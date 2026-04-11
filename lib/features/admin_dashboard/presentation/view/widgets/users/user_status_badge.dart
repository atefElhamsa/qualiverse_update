import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class UserStatusBadge extends StatelessWidget {
  final String status;

  const UserStatusBadge({super.key, required this.status});

  static const activeColor = Color(0xFF4CAF50);
  static const pendingColor = Color(0xFFFFA726);

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'Active';
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isActive ? activeColor : pendingColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomText(
          title: status,
          textStyle: const TextStyle(
            color: AppColors.white,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
