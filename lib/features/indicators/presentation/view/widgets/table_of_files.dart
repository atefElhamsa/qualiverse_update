import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class TableOfFiles extends StatelessWidget {
  const TableOfFiles({
    super.key,
    required this.indicatorsArgs,
    required this.indicators,
  });
  final IndicatorsArgs indicatorsArgs;
  final List<IndicatorModel> indicators;

  @override
  Widget build(BuildContext context) {
    return indicators.isEmpty
        ? EmptyIndicatorsList()
        : NoEmptyIndicatorsList(indicators: indicators);
  }
}
