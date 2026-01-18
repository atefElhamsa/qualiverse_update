import 'package:flutter/widgets.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class TableWithLine extends StatelessWidget {
  const TableWithLine({
    super.key,
    required this.indicatorsArgs,
    required this.indicators,
  });
  final IndicatorsArgs indicatorsArgs;
  final List<IndicatorModel> indicators;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            indicators.isEmpty
                ? const SizedBox()
                : Line(indicators: indicators),
            const SizedBox(height: 15),
            TableOfFiles(
              indicatorsArgs: indicatorsArgs,
              indicators: indicators,
            ),
          ],
        ),
      ),
    );
  }
}
