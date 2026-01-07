import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class NoEmptyIndicatorsList extends StatelessWidget {
  const NoEmptyIndicatorsList({
    super.key,
    required this.indicators,
    required this.indicatorsArgs,
  });
  final List<IndicatorModel> indicators;
  final IndicatorsArgs indicatorsArgs;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(color: Colors.transparent),
        columnWidths: {
          0: FixedColumnWidth(450.w),
          1: FixedColumnWidth(300.w),
          2: FixedColumnWidth(450.w),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: [
          tableHeader(context),
          tableSpaceBottomHeader(),
          for (final indicator in indicators) ...[
            buildTableRow(
              context: context,
              indicator: indicator,
              indicatorsArgs: indicatorsArgs,
            ),
            tableSpaceBottomHeader(),
          ],
        ],
      ),
    );
  }
}
