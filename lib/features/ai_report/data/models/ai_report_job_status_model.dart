import 'ai_report_model.dart';

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
  final String? downloadUrlDocx;
  final String? downloadUrlPdf;
  final String? downloadUrl;
  final String? error;
  final AiReportModel? reportData;

  AiReportJobStatusData({
    required this.jobId,
    required this.status,
    required this.createdAt,
    required this.completedAt,
    this.downloadUrlDocx,
    this.downloadUrlPdf,
    this.downloadUrl,
    this.error,
    this.reportData,
  });

  factory AiReportJobStatusData.fromJson(Map<String, dynamic> json) {
    return AiReportJobStatusData(
      jobId: json['job_id']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      createdAt: json['created_at']?.toString() ?? '',
      completedAt: json['completed_at']?.toString() ?? '',
      downloadUrlDocx: json['download_url_docx']?.toString(),
      downloadUrlPdf: json['download_url_pdf']?.toString(),
      downloadUrl: json['download_url']?.toString(),
      error: json['error']?.toString(),
      reportData: json['report_data'] != null
          ? AiReportModel.fromJson(json['report_data'])
          : null,
    );
  }
}
