import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class Line extends StatelessWidget {
  const Line({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 1200,
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: LinearProgressIndicator(
          value: 2 / 3, // progress = completed / total
          backgroundColor: AppColors.tableColor,
          color: AppColors.green,
          minHeight: 6,
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}