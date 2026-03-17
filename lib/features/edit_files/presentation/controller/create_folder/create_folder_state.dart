sealed class CreateFolderState {}

final class CreateFolderInitial extends CreateFolderState {}

final class CreateFolderLoading extends CreateFolderState {}

final class CreateFolderSuccess extends CreateFolderState {
  final String message;

  CreateFolderSuccess({required this.message});
}

final class CreateFolderFailure extends CreateFolderState {
  final String errorMessage;

  CreateFolderFailure({required this.errorMessage});
}
