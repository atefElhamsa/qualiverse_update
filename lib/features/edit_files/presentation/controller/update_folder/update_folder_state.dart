sealed class UpdateFolderState {}

final class UpdateFolderInitial extends UpdateFolderState {}

final class UpdateFolderLoading extends UpdateFolderState {}

final class UpdateFolderSuccess extends UpdateFolderState {
  final String message;

  UpdateFolderSuccess({required this.message});
}

final class UpdateFolderFailure extends UpdateFolderState {
  final String errorMessage;

  UpdateFolderFailure({required this.errorMessage});
}
