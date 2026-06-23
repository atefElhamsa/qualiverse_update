import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/table_column_config.dart';

import '../../routing/all_routes_imports.dart';

class BuildHeader extends StatelessWidget {
  final Color? headerColor;
  final List<TableColumnConfig> columns;
  final Color? headerTextColor;
  const BuildHeader(
    this.headerColor,
    this.headerTextColor, {
    super.key,
    required this.columns,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      decoration: BoxDecoration(
        color: headerColor ?? AppColors.grey.withOpacity(0.1),
        borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
      ),
      child: Row(
        children: columns.map((col) {
          return Expanded(
            flex: col.flex,
            child: CustomText(
              title: col.label,
              textStyle: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.bold,
                color: headerTextColor ?? AppColors.mainBlack,
              ),
              textAlign: col.textAlign,
            ),
          );
        }).toList(),
      ),
    );
  }
}
