import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class IndicatorsBody extends StatelessWidget {
  const IndicatorsBody({super.key, required this.indicatorsArgs});

  final IndicatorsArgs indicatorsArgs;

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      widget: BlocBuilder<IndicatorsCubit, IndicatorsState>(
        builder: (context, state) {
          if (state is IndicatorsLoading) {
            return Padding(
              padding: EdgeInsets.all(416.h),
              child: const CustomLoading(),
            );
          }
          if (state is IndicatorsError) {
            return Padding(
              padding: EdgeInsets.all(416.h),
              child: RetryWidget(
                title: state.message,
                onPressed: () {
                  context.read<IndicatorsCubit>().fetchIndicators(
                    criterionId: indicatorsArgs.accreditationModel.id,
                  );
                },
              ),
            );
          }
          if (state is IndicatorsSuccess) {
            final indicators = state.indicators;
            return Column(
              children: [
                IndicatorsTopAndTitle(title: indicatorsArgs.title),
                MiddleContent(
                  indicatorsArgs: indicatorsArgs,
                  indicators: indicators,
                ),
                TableWithLine(
                  indicatorsArgs: indicatorsArgs,
                  indicators: indicators,
                ),
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
