import 'package:qualiverse/features/edit_files/data/models/file_model.dart';
import 'package:qualiverse/features/edit_files/data/models/upload_file_to_folder_model.dart';

sealed class FolderFilesState {}

final class FolderFilesInitial extends FolderFilesState {}

final class FolderFilesLoading extends FolderFilesState {}

final class FolderFilesSuccess extends FolderFilesState {
  final List<FileModel> files;
  final FileModel? selectedFile;
  FolderFilesSuccess({required this.files, this.selectedFile});
}

final class FolderFilesFailure extends FolderFilesState {
  final String error;
  FolderFilesFailure({required this.error});
}

// ── Upload states ─────────────────────────────────────────────────────────────

final class UploadFilesLoading extends FolderFilesState {}

final class UploadFilesSuccess extends FolderFilesState {
  final UploadFileToFolderData data;
  UploadFilesSuccess({required this.data});
}

final class UploadFilesFailure extends FolderFilesState {
  final String error;
  UploadFilesFailure({required this.error});
}

// ── Delete states ─────────────────────────────────────────────────────────────

final class DeleteFileLoading extends FolderFilesState {
  final int fileId;
  DeleteFileLoading({required this.fileId});
}

final class DeleteFileSuccess extends FolderFilesState {
  final String message;
  DeleteFileSuccess({required this.message});
}

final class DeleteFileFailure extends FolderFilesState {
  final String error;
  DeleteFileFailure({required this.error});
}
