part of 'ai_description_cubit.dart';

sealed class AiDescriptionState {}

final class AiDescriptionInitial extends AiDescriptionState {}

final class AiDescriptionPageChanged extends AiDescriptionState {
  final int pageIndex;
  AiDescriptionPageChanged(this.pageIndex);
}

final class AiDescriptionFileUpdated extends AiDescriptionState {}

final class AiDescriptionWeeksUpdated extends AiDescriptionState {}

final class AiDescriptionUploadLoading extends AiDescriptionState {}

final class AiDescriptionUploadSuccess extends AiDescriptionState {}

final class AiDescriptionUploadError extends AiDescriptionState {
  final String message;
  AiDescriptionUploadError(this.message);
}

// Start Generation States
final class AiDescriptionStartLoading extends AiDescriptionState {}

final class AiDescriptionStartSuccess extends AiDescriptionState {
  final String generationId;
  AiDescriptionStartSuccess(this.generationId);
}

final class AiDescriptionStartError extends AiDescriptionState {
  final String message;
  AiDescriptionStartError(this.message);
}

// Confirmation States
final class AiDescriptionConfirmLoading extends AiDescriptionState {}

final class AiDescriptionConfirmSuccess extends AiDescriptionState {}

final class AiDescriptionConfirmError extends AiDescriptionState {
  final String message;
  AiDescriptionConfirmError(this.message);
}

final class AiDescriptionSubmitLoading extends AiDescriptionState {}

final class AiDescriptionSubmitSuccess extends AiDescriptionState {}

final class AiDescriptionSubmitError extends AiDescriptionState {
  final String message;
  AiDescriptionSubmitError(this.message);
}

final class AiDescriptionSubmitDetailsLoading extends AiDescriptionState {}

final class AiDescriptionSubmitDetailsSuccess extends AiDescriptionState {}

final class AiDescriptionSubmitDetailsError extends AiDescriptionState {
  final String message;
  AiDescriptionSubmitDetailsError(this.message);
}

final class AiDescriptionValidationError extends AiDescriptionState {
  final String message;
  AiDescriptionValidationError(this.message);
}

// Download States
final class AiDescriptionDownloadLoading extends AiDescriptionState {}

final class AiDescriptionDownloadSuccess extends AiDescriptionState {
  final String url;
  AiDescriptionDownloadSuccess(this.url);
}

final class AiDescriptionDownloadError extends AiDescriptionState {
  final String message;
  AiDescriptionDownloadError(this.message);
}

// Custom Upload States
final class AiDescriptionCustomUploadLoading extends AiDescriptionState {}

final class AiDescriptionCustomUploadSuccess extends AiDescriptionState {}

final class AiDescriptionCustomUploadError extends AiDescriptionState {
  final String message;
  AiDescriptionCustomUploadError(this.message);
}

// Final Confirmation States
final class AiDescriptionFinalConfirmLoading extends AiDescriptionState {}

final class AiDescriptionFinalConfirmSuccess extends AiDescriptionState {
  final String message;
  AiDescriptionFinalConfirmSuccess(this.message);
}

final class AiDescriptionFinalConfirmError extends AiDescriptionState {
  final String message;
  AiDescriptionFinalConfirmError(this.message);
}

// File Types States
final class AiDescriptionFileTypesLoading extends AiDescriptionState {}

final class AiDescriptionFileTypesSuccess extends AiDescriptionState {
  final List<AiCourseFileTypeModel> fileTypes;
  AiDescriptionFileTypesSuccess(this.fileTypes);
}

final class AiDescriptionFileTypesError extends AiDescriptionState {
  final String message;
  AiDescriptionFileTypesError(this.message);
}
