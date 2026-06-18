import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/service/ai_report_service.dart';
import '../../data/models/ai_report_job_status_model.dart';
import '../../data/models/ai_report_history_model.dart';

sealed class AiReportJobStatusState {}

class AiReportJobStatusInitial extends AiReportJobStatusState {}

class AiReportJobStatusLoading extends AiReportJobStatusState {
  final AiReportJobStatusData? data;
  AiReportJobStatusLoading({this.data});
}

class AiReportJobStatusSuccess extends AiReportJobStatusState {
  final AiReportJobStatusData data;
  AiReportJobStatusSuccess(this.data);
}

class AiReportJobStatusError extends AiReportJobStatusState {
  final String message;
  AiReportJobStatusError(this.message);
}

class AiReportJobStatusCubit extends Cubit<AiReportJobStatusState> {
  final String jobId;
  Timer? _timer;

  AiReportJobStatusCubit(this.jobId) : super(AiReportJobStatusInitial());

  void startPolling() {
    emit(AiReportJobStatusLoading());
    _fetchStatus();
    _timer = Timer.periodic(const Duration(seconds: 5), (_) {
      _fetchStatus();
    });
  }

  Future<void> _fetchStatus() async {
    try {
      final response = await AiReportService.getReportStatus(jobId);
      final data = response.data;
      if (data != null) {
        if (data.status.toLowerCase() == 'done' ||
            data.status.toLowerCase() == 'completed') {
          _timer?.cancel();

          // Fetch history to get the download URLs
          final historyResponse = await AiReportService.getHistory();
          final historyItem = historyResponse.data.firstWhere(
            (item) => item.jobId == jobId,
            orElse: () => AiReportHistoryItem(
              aiRequestId: 0,
              isPublished: false,
              files: [],
            ),
          );

          final updatedData = AiReportJobStatusData(
            jobId: data.jobId,
            status: data.status,
            createdAt: data.createdAt,
            completedAt: data.completedAt,
            files: historyItem.files.isNotEmpty ? historyItem.files : data.files,
            downloadUrl: data.downloadUrl,
            error: data.error,
            aiRequestId: historyItem.aiRequestId,
            isPublished: historyItem.isPublished,
            reportData: data.reportData,
          );

          emit(AiReportJobStatusSuccess(updatedData));
        } else if (data.status.toLowerCase() == 'failed') {
          _timer?.cancel();
          emit(AiReportJobStatusError(data.error ?? 'Job failed'));
        } else {
          // Still loading
          emit(AiReportJobStatusLoading(data: data));
        }
      }
    } catch (e) {
      _timer?.cancel();
      emit(AiReportJobStatusError(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
