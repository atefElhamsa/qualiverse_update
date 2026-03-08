import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../routing/all_routes_imports.dart';

class EvidencePerCriterionChart extends StatelessWidget {
  final List<CriterionDataModel> data;

  const EvidencePerCriterionChart({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EvidencePerCriterionCubit()..loadData(data),
      child: const EvidencePerCriterionView(),
    );
  }
}
