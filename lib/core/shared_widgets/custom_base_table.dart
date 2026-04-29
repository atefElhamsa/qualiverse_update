import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/utils/app_colors.dart';
import 'package:qualiverse/core/shared_widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';

class TableColumnConfig {
  final String label;
  final int flex;
  final TextAlign textAlign;

  TableColumnConfig({
    required this.label,
    this.flex = 1,
    this.textAlign = TextAlign.center,
  });

  TableColumnConfig copyWith({
    String? label,
    int? flex,
    TextAlign? textAlign,
  }) {
    return TableColumnConfig(
      label: label ?? this.label,
      flex: flex ?? this.flex,
      textAlign: textAlign ?? this.textAlign,
    );
  }
}

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
      return const Center(child: CircularProgressIndicator());
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
        itemBuilder: (context, index) => mobileRowBuilder!(context, items[index], index),
      );
    }

    return Column(
      children: [
        _buildHeader(),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: AppColors.grey.withOpacity(0.2),
          ),
          itemBuilder: (context, index) {
            return rowBuilder(context, items[index], index);
          },
        ),
      ],
    );
  }

  Widget _buildHeader() {
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
                fontSize: 14.sp,
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

// A helper widget for table rows to maintain consistent flex
class CustomBaseTableRow extends StatelessWidget {
  final List<Widget> children;
  final List<int> flexValues;
  final VoidCallback? onTap;
  final Color? backgroundColor;

  const CustomBaseTableRow({
    super.key,
    required this.children,
    required this.flexValues,
    this.onTap,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        child: Row(
          children: children.asMap().entries.map((entry) {
            final index = entry.key;
            final child = entry.value;
            final flex = index < flexValues.length ? flexValues[index] : 1;
            return Expanded(
              flex: flex,
              child: child,
            );
          }).toList(),
        ),
      ),
    );
  }
}
