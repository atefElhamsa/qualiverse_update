import 'package:equatable/equatable.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_history_model.dart';

abstract class AiReportHistoryState extends Equatable {
  const AiReportHistoryState();

  @override
  List<Object?> get props => [];
}

class AiReportHistoryInitial extends AiReportHistoryState {}

class AiReportHistoryLoading extends AiReportHistoryState {}

class AiReportHistoryLoaded extends AiReportHistoryState {
  final List<AiReportHistoryItem> historyItems;

  const AiReportHistoryLoaded(this.historyItems);

  @override
  List<Object?> get props => [historyItems];
}

class AiReportHistoryError extends AiReportHistoryState {
  final String message;

  const AiReportHistoryError(this.message);

  @override
  List<Object?> get props => [message];
}
