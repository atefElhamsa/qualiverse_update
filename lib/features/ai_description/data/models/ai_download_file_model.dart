import 'package:qualiverse/routing/all_routes_imports.dart';

class AiDownloadFileModel {
  final AiDownloadFileData? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  AiDownloadFileModel({this.data, required this.isSuccess, this.error});

  factory AiDownloadFileModel.fromJson(Map<String, dynamic> json) {
    return AiDownloadFileModel(
      data: json['data'] != null ? AiDownloadFileData.fromJson(json['data']) : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null ? ApiErrorModel.fromJson(json['error']) : null,
    );
  }
}

class AiDownloadFileData {
  final String url;
  final String fileName;
  final String fileType;

  AiDownloadFileData({
    required this.url,
    required this.fileName,
    required this.fileType,
  });

  factory AiDownloadFileData.fromJson(Map<String, dynamic> json) {
    return AiDownloadFileData(
      url: json['url'],
      fileName: json['fileName'],
      fileType: json['fileType'],
    );
  }
}
