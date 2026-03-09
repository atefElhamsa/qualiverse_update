import '../../../../../routing/all_routes_imports.dart';

sealed class EvidencePerCriterionState {}

class EvidencePerCriterionInitial extends EvidencePerCriterionState {}

class EvidencePerCriterionLoaded extends EvidencePerCriterionState {
  final List<CriterionDataModel> data;

  EvidencePerCriterionLoaded({required this.data});
}
