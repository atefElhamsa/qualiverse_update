// import 'package:flutter/widgets.dart';
// import 'package:qualiverse/routing/all_routes_imports.dart';
//
// class TableWithLine extends StatelessWidget {
//   const TableWithLine({
//     super.key,
//     required this.indicatorsArgs,
//     required this.indicators,
//   });
//   final IndicatorsArgs indicatorsArgs;
//   final List<IndicatorModel> indicators;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: SingleChildScrollView(
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             indicators.isEmpty
//                 ? const SizedBox()
//                 : Line(indicators: indicators),
//             const SizedBox(height: 15),
//             TableOfFiles(
//               indicatorsArgs: indicatorsArgs,
//               indicators: indicators,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return BlocBuilder<IndicatorsCubit, IndicatorsState>(
      builder: (context, state) {
        // ✅ بنجيب الـ indicators من الـ state دايماً
        final updatedIndicators = state is IndicatorsSuccess
            ? state.indicators
            : indicators;

        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                updatedIndicators.isEmpty
                    ? const SizedBox()
                    : Line(indicators: updatedIndicators), // ✅ بنبعت المحدثة
                const SizedBox(height: 15),
                TableOfFiles(
                  indicatorsArgs: indicatorsArgs,
                  indicators: updatedIndicators, // ✅ بنبعت المحدثة
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
