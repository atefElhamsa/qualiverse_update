import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class TitleDataWidget extends StatelessWidget {
  const TitleDataWidget({super.key, required this.title, required this.number});

  final String title;
  final String number;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 5,
        children: [
          CustomText(
            title: title.tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontSize: 16),
          ),
          CustomText(
            title: number,
            textStyle: Theme.of(context).textTheme.displaySmall!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
