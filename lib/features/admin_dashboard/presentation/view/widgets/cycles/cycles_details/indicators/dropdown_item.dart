import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class DropdownItem extends StatelessWidget {
  const DropdownItem({
    super.key,
    required this.name,
    required this.isSelected,
    required this.onTap,
  });

  final String name;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          color: isSelected
              ? AppColors.blue.withOpacity(0.08)
              : Colors.transparent,
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
          child: CustomText(
            title: name,
            textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontSize: 14.sp,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
