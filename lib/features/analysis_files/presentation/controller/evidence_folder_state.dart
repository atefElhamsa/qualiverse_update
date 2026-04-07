import '../../../../routing/all_routes_imports.dart';

sealed class EvidenceFolderState {}

final class EvidenceFolderInitial extends EvidenceFolderState {}

final class EvidenceFolderLoading extends EvidenceFolderState {}

final class EvidenceFolderSuccess extends EvidenceFolderState {
  final List<EvidenceFolderModel> evidenceFolders;
  final EvidenceFolderModel? selectedEvidenceFolder;

  EvidenceFolderSuccess({
    required this.evidenceFolders,
    this.selectedEvidenceFolder,
  });
}

final class EvidenceFolderError extends EvidenceFolderState {
  final String message;

  EvidenceFolderError({required this.message});
}
