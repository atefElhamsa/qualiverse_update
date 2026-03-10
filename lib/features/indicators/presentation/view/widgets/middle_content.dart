import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class MiddleContent extends StatelessWidget {
  const MiddleContent({
    super.key,
    required this.indicatorsArgs,
    required this.indicators,
  });

  final IndicatorsArgs indicatorsArgs;
  final List<IndicatorModel> indicators;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomText(
              title: indicatorsArgs.accreditationModel.name,
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
              ),
            ),
            const Text(' - '),
            CustomText(
              title: context.standardTitle(indicatorsArgs.index),
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        indicators.isEmpty
            ? const SizedBox()
            : Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(
                    title: 'indicatorsCompleted'.tr(),
                    textStyle: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28.sp,
                    ),
                  ),
                  const SizedBox(width: 10),
                  CustomText(
                    title:
                        '${indicators.where((element) => element.filePath != null).length} / ${indicators.length}',
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                ],
              ),
      ],
    );
  }
}
