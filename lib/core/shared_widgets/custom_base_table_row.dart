import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            return Expanded(flex: flex, child: child);
          }).toList(),
        ),
      ),
    );
  }
}
