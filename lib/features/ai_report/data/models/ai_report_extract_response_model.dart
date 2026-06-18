import 'ai_report_model.dart';

class AiReportExtractResponse {
  final bool isSuccess;
  final int aiRequestId;
  final String downloadUrlDocx;
  final String downloadUrlPdf;
  final String downloadUrl;
  final double processingTimeSeconds;
  final AiReportModel reportData;
  final Map<String, dynamic> rawJson;

  AiReportExtractResponse({
    required this.isSuccess,
    this.aiRequestId = 0,
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
      aiRequestId:
          (data['aiRequestId'] as int?) ??
          int.tryParse(data['job_id']?.toString() ?? '') ??
          0,
      downloadUrlDocx:
          data['downloadUrlDocx']?.toString() ??
          data['download_url_docx']?.toString() ??
          '',
      downloadUrlPdf:
          data['downloadUrlPdf']?.toString() ??
          data['download_url_pdf']?.toString() ??
          '',
      downloadUrl:
          data['downloadUrl']?.toString() ??
          data['download_url']?.toString() ??
          '',
      processingTimeSeconds:
          (data['processingTimeSeconds'] as num?)?.toDouble() ??
          (data['processing_time_seconds'] as num?)?.toDouble() ??
          0.0,
      reportData: AiReportModel.fromJson(
        data['reportData'] ?? data['report_data'] ?? data,
      ),
      rawJson:
          (data['reportData'] as Map<String, dynamic>?) ??
          (data['report_data'] as Map<String, dynamic>?) ??
          data,
    );
  }
}
