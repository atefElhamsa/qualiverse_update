import 'package:qualiverse/features/edit_files/data/models/evidence_folder_model.dart';

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
