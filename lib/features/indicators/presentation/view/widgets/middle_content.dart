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
              title: indicatorsArgs.accreditationModel.localizedName(context),
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
              ),
            ),
            Text(' - '),
            CustomText(
              title: context.standardTitle(indicatorsArgs.index),
              textStyle: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 8),
        indicators.isEmpty
            ? SizedBox()
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
                  SizedBox(width: 10),
                  Text(
                    '1 / ${indicators.length}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
                  ),
                ],
              ),
      ],
    );
  }
}
