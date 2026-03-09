class EvidenceDataModel {
  final String criterion;
  final int pending;
  final int reviewed;
  final int rejected;

  EvidenceDataModel({
    required this.criterion,
    required this.pending,
    required this.reviewed,
    required this.rejected,
  });

  int get total => pending + reviewed + rejected;
}
