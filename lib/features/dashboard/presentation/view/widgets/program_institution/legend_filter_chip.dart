import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class LegendFilterChip extends StatelessWidget {
  final String label;
  final Color color;
  final bool isSelected;
  final VoidCallback onTap;
  final bool enabled;

  const LegendFilterChip({
    super.key,
    required this.label,
    required this.color,
    required this.isSelected,
    required this.onTap,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 12,
            height: 12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isSelected ? color : AppColors.grey,
              border: Border.all(color: color, width: 1.5),
            ),
          ),
          const SizedBox(width: 4),
          CustomText(
            title: label,
            textStyle: GoogleFonts.inter(
              fontSize: 12,
              color: isSelected ? Colors.black87 : Colors.grey,
              decoration: isSelected ? null : TextDecoration.lineThrough,
            ),
          ),
        ],
      ),
    );
  }
}
