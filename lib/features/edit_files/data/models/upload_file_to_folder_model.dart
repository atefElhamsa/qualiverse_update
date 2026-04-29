import 'package:qualiverse/routing/all_routes_imports.dart';

class UploadFileToFolderModel {
  final UploadFileToFolderData? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  const UploadFileToFolderModel({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory UploadFileToFolderModel.fromJson(Map<String, dynamic> json) {
    return UploadFileToFolderModel(
      data: json['data'] != null
          ? UploadFileToFolderData.fromJson(
              json['data'] as Map<String, dynamic>,
            )
          : null,
      isSuccess: json['isSuccess'] as bool,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class UploadFileToFolderData {
  final String message;
  final List<FileModel> uploadedFiles;

  const UploadFileToFolderData({
    required this.message,
    required this.uploadedFiles,
  });

  factory UploadFileToFolderData.fromJson(Map<String, dynamic> json) {
    return UploadFileToFolderData(
      message: json['message'] as String,
      uploadedFiles: (json['uploadedFiles'] as List)
          .map((e) => FileModel.fromJson(e))
          .toList(),
    );
  }
}
