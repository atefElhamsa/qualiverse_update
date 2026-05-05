import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class AssignmentsHeader extends StatelessWidget {
  const AssignmentsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.mainBlack.withOpacity(0.05),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      child: Row(
        children: [
          _buildHeaderItem('indicatorsName'.tr(), 2),
          _buildHeaderItem('description'.tr(), 4),
          _buildHeaderItem('assignedDoctor'.tr(), 2),
          _buildHeaderItem('deadline'.tr(), 2),
          _buildHeaderItem('status'.tr(), 2),
          _buildHeaderItem('action'.tr(), 2),
        ],
      ),
    );
  }

  Widget _buildHeaderItem(String title, int flex) {
    return Expanded(
      flex: flex,
      child: CustomText(
        textAlign: TextAlign.center,
        title: title,
        textStyle: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.bold,
          color: AppColors.mainBlack,
        ),
      ),
    );
  }
}
