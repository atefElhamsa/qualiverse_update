import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFileResponse {
  final List<EvidenceFileModel>? files;
  final bool isSuccess;
  final ApiErrorModel? error;

  EvidenceFileResponse({this.files, required this.isSuccess, this.error});

  factory EvidenceFileResponse.fromJson(Map<String, dynamic> json) {
    return EvidenceFileResponse(
      files: json['data'] != null 
          ? (json['data'] as List).map((e) => EvidenceFileModel.fromJson(e)).toList()
          : null,
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class EvidenceFileModel {
  final int id;
  final String fileName;
  final String filePath;
  final String fileSize;
  final String fileType;
  final String? departmentName;
  final int yearNumber;
  final int levelNumber;
  final int courseId;
  final String courseName;
  final String createdOn;

  const EvidenceFileModel({
    required this.id,
    required this.fileName,
    required this.filePath,
    required this.fileSize,
    required this.fileType,
    this.departmentName,
    required this.yearNumber,
    required this.levelNumber,
    required this.courseId,
    required this.courseName,
    required this.createdOn,
  });

  factory EvidenceFileModel.fromJson(Map<String, dynamic> json) {
    return EvidenceFileModel(
      id: (json['id'] ?? 0) as int,
      fileName: (json['fileName'] ?? '') as String,
      filePath: (json['filePath'] ?? '') as String,
      fileSize: (json['fileSize'] ?? '0') as String,
      fileType: (json['fileType'] ?? '') as String,
      departmentName: json['departmentName'] as String?,
      yearNumber: (json['yearNumber'] ?? 0) as int,
      levelNumber: (json['levelNumber'] ?? 0) as int,
      courseId: (json['courseId'] ?? 0) as int,
      courseName: (json['courseName'] ?? '') as String,
      createdOn: (json['createdOn'] ?? '') as String,
    );
  }
}
