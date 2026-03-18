sealed class DeleteFolderState {}

final class DeleteFolderInitial extends DeleteFolderState {}

final class DeleteFolderLoading extends DeleteFolderState {}

final class DeleteFolderSuccess extends DeleteFolderState {
  final String message;

  DeleteFolderSuccess({required this.message});
}

final class DeleteFolderFailure extends DeleteFolderState {
  final String errorMessage;

  DeleteFolderFailure({required this.errorMessage});
}
