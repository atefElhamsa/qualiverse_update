import '../../data/models/ai_report_status_model.dart';

sealed class AiReportStatusState {}

final class AiReportStatusInitial extends AiReportStatusState {}

final class AiReportStatusLoading extends AiReportStatusState {}

final class AiReportStatusLoaded extends AiReportStatusState {
  final AiReportHealthModel health;
  final AiReportProvidersModel providers;
  final String? selectedProvider;
  final String? selectedCourseNature; // "practical" | "clinical" | null
  AiReportStatusLoaded({
    required this.health,
    required this.providers,
    this.selectedProvider,
    this.selectedCourseNature,
  });
}

final class AiReportStatusError extends AiReportStatusState {
  final String errorMessage;
  AiReportStatusError({required this.errorMessage});
}
