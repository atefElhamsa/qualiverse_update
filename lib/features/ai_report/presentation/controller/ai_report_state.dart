sealed class AiReportState {}

final class AiReportInitial extends AiReportState {}

final class AiReportPageChanged extends AiReportState {
  final int pageIndex;
  AiReportPageChanged(this.pageIndex);
}

final class AiReportInstructorsChanged extends AiReportState {}

final class AiReportLoading extends AiReportState {}

final class AiReportSuccess extends AiReportState {
  final String message;
  AiReportSuccess(this.message);
}

final class AiReportError extends AiReportState {
  final String message;
  AiReportError(this.message);
}
