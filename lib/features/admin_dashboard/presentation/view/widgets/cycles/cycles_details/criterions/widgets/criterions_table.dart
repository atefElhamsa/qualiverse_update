import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

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
            title: 'noCriterionsAvailable'.tr(),
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
