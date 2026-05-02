import 'package:qualiverse/features/edit_files/data/models/evidence_file_model.dart';
import 'package:qualiverse/features/edit_files/data/models/evidence_file_statistics_model.dart';

abstract class EvidenceFolderFilesState {}

class EvidenceFolderFilesInitial extends EvidenceFolderFilesState {}

class EvidenceFolderFilesLoading extends EvidenceFolderFilesState {}

class EvidenceFolderFilesSuccess extends EvidenceFolderFilesState {
  final List<EvidenceFileModel> files;
  EvidenceFolderFilesSuccess({required this.files});
}

class EvidenceFolderFilesFailure extends EvidenceFolderFilesState {
  final String error;
  EvidenceFolderFilesFailure({required this.error});
}

class UploadEvidenceFilesLoading extends EvidenceFolderFilesState {}

class UploadEvidenceFilesSuccess extends EvidenceFolderFilesState {
  final String message;
  UploadEvidenceFilesSuccess({required this.message});
}

class UploadEvidenceFilesFailure extends EvidenceFolderFilesState {
  final String error;
  UploadEvidenceFilesFailure({required this.error});
}

class DeleteEvidenceFileLoading extends EvidenceFolderFilesState {}

class DeleteEvidenceFileSuccess extends EvidenceFolderFilesState {
  final String message;
  DeleteEvidenceFileSuccess({required this.message});
}

class DeleteEvidenceFileFailure extends EvidenceFolderFilesState {
  final String error;
  DeleteEvidenceFileFailure({required this.error});
}

// Statistics States
class GetEvidenceStatisticsLoading extends EvidenceFolderFilesState {}

class GetEvidenceStatisticsSuccess extends EvidenceFolderFilesState {
  final List<EvidenceFileStatisticsModel> statistics;
  
  GetEvidenceStatisticsSuccess({required this.statistics});
}

class GetEvidenceStatisticsFailure extends EvidenceFolderFilesState {
  final String error;
  GetEvidenceStatisticsFailure({required this.error});
}
