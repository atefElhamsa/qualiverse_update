import '../../../../routing/all_routes_imports.dart';

sealed class FilesState {}

final class FilesInitial extends FilesState {}

final class FilesLoading extends FilesState {}

final class FilesLoaded extends FilesState {
  final List<FileModel> files;

  FilesLoaded({required this.files});
}

final class FilesError extends FilesState {
  final String errorMessage;

  FilesError({required this.errorMessage});
}
