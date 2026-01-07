import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class IndicatorsScreen extends StatelessWidget {
  const IndicatorsScreen({super.key, required this.indicatorsArgs});

  final IndicatorsArgs indicatorsArgs;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => IndicatorsCubit()
        ..fetchIndicators(criterionId: indicatorsArgs.accreditationModel.id),
      child: MainWrapper(child: IndicatorsBody(indicatorsArgs: indicatorsArgs)),
    );
  }
}
