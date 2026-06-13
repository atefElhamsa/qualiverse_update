import 'ai_report_model.dart';

class AiReportExtractResponse {
  final bool isSuccess;
  final String jobId;
  final String downloadUrlDocx;
  final String downloadUrlPdf;
  final String downloadUrl;
  final double processingTimeSeconds;
  final AiReportModel reportData;
  final Map<String, dynamic> rawJson;

  AiReportExtractResponse({
    required this.isSuccess,
    this.jobId = '',
    this.downloadUrlDocx = '',
    this.downloadUrlPdf = '',
    this.downloadUrl = '',
    this.processingTimeSeconds = 0.0,
    required this.reportData,
    this.rawJson = const {},
  });

  factory AiReportExtractResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'] ?? {};
    return AiReportExtractResponse(
      isSuccess: json['isSuccess'] ?? false,
      jobId: data['job_id']?.toString() ?? '',
      downloadUrlDocx: data['download_url_docx']?.toString() ?? '',
      downloadUrlPdf: data['download_url_pdf']?.toString() ?? '',
      downloadUrl: data['download_url']?.toString() ?? '',
      processingTimeSeconds: (data['processing_time_seconds'] as num?)?.toDouble() ?? 0.0,
      reportData: AiReportModel.fromJson(data['report_data'] ?? data),
      rawJson: (data['report_data'] as Map<String, dynamic>?) ?? data,
    );
  }
}
