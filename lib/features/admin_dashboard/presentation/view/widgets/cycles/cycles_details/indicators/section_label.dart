import 'package:flutter/material.dart';

import '../../../../../../../../core/all_core_imports/all_core_imports.dart';

class SectionLabel extends StatelessWidget {
  const SectionLabel({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return CustomText(
      title: title,
      textStyle: Theme.of(
        context,
      ).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
    );
  }
}
