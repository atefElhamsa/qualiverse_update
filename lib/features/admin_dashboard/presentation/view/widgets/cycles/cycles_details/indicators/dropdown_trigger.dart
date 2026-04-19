import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class DropdownTrigger extends StatelessWidget {
  const DropdownTrigger({
    super.key,
    required this.label,
    required this.isPlaceholder,
    required this.isOpen,
    required this.onTap,
  });

  final String label;
  final bool isPlaceholder;
  final bool isOpen;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
        decoration: BoxDecoration(
          border: Border.all(color: isOpen ? AppColors.blue : AppColors.grey),
          borderRadius: isOpen
              ? BorderRadius.vertical(top: Radius.circular(10.r))
              : BorderRadius.circular(10.r),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomText(
              title: label,
              textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                fontSize: 14.sp,
                color: isPlaceholder ? AppColors.grey : null,
              ),
            ),
            MouseRegion(
              cursor: SystemMouseCursors.click,
              child: AnimatedRotation(
                turns: isOpen ? 0.5 : 0,
                duration: const Duration(milliseconds: 200),
                child: const Icon(Icons.keyboard_arrow_down),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
