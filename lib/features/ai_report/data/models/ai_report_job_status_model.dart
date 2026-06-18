import 'ai_report_model.dart';
import 'ai_report_history_model.dart';

class AiReportJobStatusResponse {
  final bool isSuccess;
  final AiReportJobStatusData? data;

  AiReportJobStatusResponse({required this.isSuccess, this.data});

  factory AiReportJobStatusResponse.fromJson(Map<String, dynamic> json) {
    return AiReportJobStatusResponse(
      isSuccess: json['isSuccess'] ?? false,
      data: json['data'] != null
          ? AiReportJobStatusData.fromJson(json['data'])
          : null,
    );
  }
}

class AiReportJobStatusData {
  final String jobId;
  final String status;
  final String createdAt;
  final String completedAt;
  final List<AiReportHistoryFile>? files;
  final String? downloadUrl;
  final String? error;
  final int? aiRequestId;
  final bool? isPublished;
  final AiReportModel? reportData;

  AiReportJobStatusData({
    required this.jobId,
    required this.status,
    required this.createdAt,
    required this.completedAt,
    this.files,
    this.downloadUrl,
    this.error,
    this.aiRequestId,
    this.isPublished,
    this.reportData,
  });

  factory AiReportJobStatusData.fromJson(Map<String, dynamic> json) {
    return AiReportJobStatusData(
      jobId: json['job_id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      completedAt: json['completed_at']?.toString() ?? '',
      files: json['files'] != null
          ? (json['files'] as List<dynamic>)
              .map((item) => AiReportHistoryFile.fromJson(item))
              .toList()
          : null,
      downloadUrl:
          json['downloadUrl']?.toString() ?? json['download_url']?.toString(),
      error: json['error']?.toString(),
      reportData: (json['reportData'] ?? json['report_data']) != null
          ? AiReportModel.fromJson(json['reportData'] ?? json['report_data'])
          : null,
    );
  }
}
