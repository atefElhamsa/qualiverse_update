import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_state.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/evidence_per_criterion/evidence_per_criterion_cubit.dart';
import 'package:qualiverse/features/dashboard/data/models/criterion_data_model.dart';
import 'evidence_per_criterion_view.dart';

class EvidencePerCriterionChart extends StatelessWidget {
  const EvidencePerCriterionChart({super.key});

  @override
  Widget build(BuildContext context) {
    return const EvidencePerCriterionView();
  }
}
