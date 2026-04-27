import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/criterion_item_model.dart';
import 'criterions_header.dart';
import 'criterions_row_widget.dart';

class CriterionsTable extends StatelessWidget {
  final List<CriterionItemModel> criterions;
  const CriterionsTable({super.key, required this.criterions});

  @override
  Widget build(BuildContext context) {
    if (criterions.isEmpty) {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 40.h),
          child: CustomText(
            title: 'No Criterions Available',
            textStyle: Theme.of(context).textTheme.headlineLarge!,
          ),
        ),
      );
    }

    return Column(
      children: [
        const CriterionsHeader(),
        ...criterions.asMap().entries.map(
          (entry) => CriterionsRowWidget(
            criterion: entry.value,
            index: entry.key,
            total: criterions.length,
          ),
        ),
      ],
    );
  }
}
