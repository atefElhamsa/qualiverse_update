import 'package:qualiverse/routing/all_routes_imports.dart';

abstract class EvidenceFolderState {}

class EvidenceFolderInitial extends EvidenceFolderState {}

class EvidenceFolderLoading extends EvidenceFolderState {}

class EvidenceFolderSuccess extends EvidenceFolderState {
  final List<EvidenceFolderModel> evidenceFolders;
  final EvidenceFolderModel? selectedEvidenceFolder;

  EvidenceFolderSuccess({
    required this.evidenceFolders,
    this.selectedEvidenceFolder,
  });
}

class EvidenceFolderError extends EvidenceFolderState {
  final String message;
  EvidenceFolderError({required this.message});
}
