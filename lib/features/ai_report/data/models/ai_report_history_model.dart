import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportHistoryResponse {
  final bool isSuccess;
  final List<AiReportHistoryItem>? data;
  final ApiErrorModel? error;

  AiReportHistoryResponse({
    required this.isSuccess,
    required this.data,
    required this.error,
  });

  factory AiReportHistoryResponse.fromJson(Map<String, dynamic> json) {
    return AiReportHistoryResponse(
      isSuccess: json['isSuccess'] ?? false,
      data:
          (json['data'] as List<dynamic>?)
              ?.map((item) => AiReportHistoryItem.fromJson(item))
              .toList() ??
          [],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class AiReportHistoryItem {
  final int aiRequestId;
  final int? courseId;
  final String? courseCode;
  final String? jobId;
  final String? requestType;
  final String? status;
  final String? provider;
  final bool isPublished;
  final String? createdOn;
  final List<AiReportHistoryFile> files;

  AiReportHistoryItem({
    required this.aiRequestId,
    this.courseId,
    this.courseCode,
    this.jobId,
    this.requestType,
    this.status,
    this.provider,
    required this.isPublished,
    this.createdOn,
    required this.files,
  });

  factory AiReportHistoryItem.fromJson(Map<String, dynamic> json) {
    return AiReportHistoryItem(
      aiRequestId: json['aiRequestId'] ?? 0,
      courseId: json['courseId'],
      courseCode: json['courseCode']?.toString(),
      jobId: json['jobId']?.toString(),
      requestType: json['requestType']?.toString(),
      status: json['status']?.toString(),
      provider: json['provider']?.toString(),
      isPublished: json['isPublished'] ?? false,
      createdOn: json['createdOn']?.toString(),
      files:
          (json['files'] as List<dynamic>?)
              ?.map((item) => AiReportHistoryFile.fromJson(item))
              .toList() ??
          [],
    );
  }
}

class AiReportHistoryFile {
  final int id;
  final String fileName;
  final String fileType;
  final String downloadUrl;

  AiReportHistoryFile({
    required this.id,
    required this.fileName,
    required this.fileType,
    required this.downloadUrl,
  });

  factory AiReportHistoryFile.fromJson(Map<String, dynamic> json) {
    return AiReportHistoryFile(
      id: json['id'] ?? 0,
      fileName: json['fileName']?.toString() ?? '',
      fileType: json['fileType']?.toString() ?? '',
      downloadUrl: json['downloadUrl']?.toString() ?? '',
    );
  }
}
