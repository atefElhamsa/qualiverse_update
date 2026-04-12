import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class BuildTable extends StatelessWidget {
  const BuildTable({super.key, required this.items});

  final List<StandardsIndicatorModel> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const BuildHeader(),
          if (items.isEmpty)
            const Padding(
              padding: EdgeInsets.all(24),
              child: CustomText(
                title: 'No data found',
                textStyle: TextStyle(color: AppColors.grey),
              ),
            )
          else
            ...items.asMap().entries.map(
              (entry) => BuildRow(
                item: entry.value,
                index: entry.key,
                total: items.length,
              ),
            ),
        ],
      ),
    );
  }
}
