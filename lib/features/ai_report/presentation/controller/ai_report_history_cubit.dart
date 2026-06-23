import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/ai_report/data/models/ai_report_history_model.dart';
import 'package:qualiverse/features/ai_report/data/service/ai_report_service.dart';
import 'ai_report_history_state.dart';

class AiReportHistoryCubit extends Cubit<AiReportHistoryState> {
  AiReportHistoryCubit() : super(AiReportHistoryInitial());

  Future<void> fetchHistory() async {
    emit(AiReportHistoryLoading());
    try {
      final response = await AiReportService.getHistory();
      if (response.isSuccess) {
        // Sort by createdOn if needed, or simply return the data
        emit(AiReportHistoryLoaded(response.data ?? []));
      } else {
        emit(
          AiReportHistoryError(
            response.error?.description ?? 'Unknown error occurred',
          ),
        );
      }
    } catch (e) {
      emit(AiReportHistoryError(e.toString()));
    }
  }

  // Publish report directly from the history page
  Future<void> publishReport(int aiRequestId) async {
    // If we're not currently loaded, we can't easily update the state, but we could re-fetch.
    if (state is! AiReportHistoryLoaded) return;

    final currentState = state as AiReportHistoryLoaded;
    try {
      final publishResponse = await AiReportService.publishReport(aiRequestId);
      if (publishResponse.isSuccess) {
        // Find and update the item
        final updatedItems = currentState.historyItems.map((item) {
          if (item.aiRequestId == aiRequestId) {
            return AiReportHistoryItem(
              aiRequestId: item.aiRequestId,
              courseId: item.courseId,
              courseCode: item.courseCode,
              jobId: item.jobId,
              requestType: item.requestType,
              status: item.status,
              provider: item.provider,
              isPublished: true, // Now published
              createdOn: item.createdOn,
              files: item.files,
            );
          }
          return item;
        }).toList();

        emit(AiReportHistoryLoaded(updatedItems));
      } else {
        // Could emit an error state or a specific state to show a toast,
        // but for simplicity we can just leave it as is or trigger a refresh.
        // Or re-emit loaded to trigger build.
      }
    } catch (e) {
      // Handle error (e.g. show toast)
    }
  }
}
