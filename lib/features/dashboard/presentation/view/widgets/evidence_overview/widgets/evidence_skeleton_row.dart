import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class EvidenceSkeletonRow extends StatelessWidget {
  const EvidenceSkeletonRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(width: 90, height: 10, decoration: BoxDecoration(color: AppColors.textGrey.withOpacity(0.05), borderRadius: BorderRadius.circular(2))),
          const SizedBox(width: 6),
          Expanded(child: Container(height: 28, decoration: BoxDecoration(color: AppColors.textGrey.withOpacity(0.05), borderRadius: BorderRadius.circular(3.r)))),
          const SizedBox(width: 8),
          Container(width: 20, height: 10, decoration: BoxDecoration(color: AppColors.textGrey.withOpacity(0.05), borderRadius: BorderRadius.circular(2))),
        ],
      ),
    );
  }
}
