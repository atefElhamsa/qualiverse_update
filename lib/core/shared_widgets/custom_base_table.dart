import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/build_header.dart';
import 'package:qualiverse/core/shared_widgets/custom_loading.dart';
import 'package:qualiverse/core/utils/app_colors.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'table_column_config.dart';

class CustomBaseTable<T> extends StatelessWidget {
  final List<TableColumnConfig> columns;
  final List<T> items;
  final Widget Function(BuildContext, T, int) rowBuilder;
  final Widget Function(BuildContext, T, int)? mobileRowBuilder;
  final bool isLoading;
  final Widget? emptyWidget;
  final double breakpoint;

  final Color? headerColor;
  final Color? headerTextColor;

  const CustomBaseTable({
    super.key,
    required this.columns,
    required this.items,
    required this.rowBuilder,
    this.mobileRowBuilder,
    this.isLoading = false,
    this.emptyWidget,
    this.breakpoint = 900,
    this.headerColor,
    this.headerTextColor,
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const CustomLoading();
    }

    if (items.isEmpty) {
      return emptyWidget ??
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 40.h),
              child: CustomText(
                title: 'noDataAvailable'.tr(),
                textStyle: Theme.of(context).textTheme.headlineLarge!,
              ),
            ),
          );
    }

    final isSmall = MediaQuery.of(context).size.width < breakpoint;

    if (isSmall && mobileRowBuilder != null) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) =>
            mobileRowBuilder!(context, items[index], index),
      );
    }

    return Column(
      children: [
        BuildHeader(headerColor, headerTextColor, columns: columns),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) =>
              Divider(height: 1, color: AppColors.grey.withOpacity(0.2)),
          itemBuilder: (context, index) {
            return rowBuilder(context, items[index], index);
          },
        ),
      ],
    );
  }
}
