import '../../../../core/all_core_imports/all_core_imports.dart';

class FileResponse {
  final List<FileModel>? files;
  final bool isSuccess;
  final ApiErrorModel? error;

  FileResponse({this.files, required this.isSuccess, this.error});

  factory FileResponse.fromJson(Map<String, dynamic> json) {
    return FileResponse(
      files: (json['data'] as List).map((e) => FileModel.fromJson(e)).toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class FileModel {
  final int id;
  final String fileName;
  final String fileSize;
  final String filePath;
  final String fileType;
  final bool isFromAI;

  const FileModel({
    required this.id,
    required this.fileName,
    required this.fileSize,
    required this.filePath,
    required this.fileType,
    required this.isFromAI,
  });

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: json['id'] as int,
      fileName: json['fileName'] as String,
      fileSize: json['fileSize'] as String,
      filePath: json['filePath'] as String,
      fileType: json['fileType'] as String,
      isFromAI: json['isFromAI'] as bool,
    );
  }
}
