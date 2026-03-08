sealed class EvidenceStatusState {}

class EvidenceStatusInitial extends EvidenceStatusState {}

class EvidenceStatusActiveIndex extends EvidenceStatusState {
  final int activeIndex;

  EvidenceStatusActiveIndex({required this.activeIndex});
}