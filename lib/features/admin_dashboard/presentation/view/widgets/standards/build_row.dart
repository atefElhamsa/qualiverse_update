import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class BuildRow extends StatelessWidget {
  final StandardsIndicatorModel item;
  final int index;
  final int total;

  const BuildRow({
    super.key,
    required this.item,
    required this.index,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  title: item.standard,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
                ),
              ),
              Expanded(
                child: CustomText(
                  title: item.indicator,
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 14.sp),
                ),
              ),
              Expanded(
                child: Center(child: BuildStatusBadge(status: item.status)),
              ),
            ],
          ),
        ),
        if (index < total - 1)
          const Divider(color: AppColors.white, thickness: 2),
      ],
    );
  }
}
