import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class UserStatusBadge extends StatelessWidget {
  final String status;
  final bool isDisabled;

  const UserStatusBadge({
    super.key,
    required this.status,
    this.isDisabled = false,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = status == 'Active';
    return MouseRegion(
      cursor: isDisabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isDisabled
              ? Colors.grey
              : isActive
              ? AppColors.green
              : AppColors.orange,
          borderRadius: BorderRadius.circular(20),
        ),
        child: CustomText(
          title: status.toLowerCase().tr(),
          textStyle: TextStyle(
            color: AppColors.white,
            fontSize: 12.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
