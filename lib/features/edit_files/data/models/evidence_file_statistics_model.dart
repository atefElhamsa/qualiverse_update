import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceFileStatisticsModelResponse {
  final List<EvidenceFileStatisticsModel>? data;
  final bool isSuccess;
  final ApiErrorModel? error;

  EvidenceFileStatisticsModelResponse({
    this.data,
    required this.isSuccess,
    this.error,
  });

  factory EvidenceFileStatisticsModelResponse.fromJson(Map<String, dynamic> json) {
    return EvidenceFileStatisticsModelResponse(
      data: json['data'] != null
          ? (json['data'] as List)
              .map((e) => EvidenceFileStatisticsModel.fromJson(e))
              .toList()
          : null,
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class EvidenceFileStatisticsModel {
  final int? id;
  final String? fileName;
  final String? filePath;
  final String? fileSize;
  final String? fileType;
  final String? departmentName;
  final int? yearNumber;
  final int? levelNumber;
  final DateTime? createdOn;

  const EvidenceFileStatisticsModel({
    this.id,
    this.fileName,
    this.filePath,
    this.fileSize,
    this.fileType,
    this.departmentName,
    this.yearNumber,
    this.levelNumber,
    this.createdOn,
  });

  factory EvidenceFileStatisticsModel.fromJson(Map<String, dynamic> json) {
    return EvidenceFileStatisticsModel(
      id: int.tryParse(json['id']?.toString() ?? ''),
      fileName: json['fileName']?.toString(),
      filePath: json['filePath']?.toString(),
      fileSize: json['fileSize']?.toString(),
      fileType: json['fileType']?.toString(),
      departmentName: json['departmentName']?.toString(),
      yearNumber: int.tryParse(json['yearNumber']?.toString() ?? ''),
      levelNumber: int.tryParse(json['levelNumber']?.toString() ?? ''),
      createdOn: json['createdOn'] != null
          ? DateTime.tryParse(json['createdOn'].toString())
          : null,
    );
  }

  EvidenceFileModel toEvidenceFileModel() {
    return EvidenceFileModel(
      id: id ?? 0,
      fileName: fileName ?? '',
      filePath: filePath ?? '',
      fileSize: fileSize ?? '',
      fileType: fileType ?? '',
      courseName: 'Statistics',
      courseId: 0,
      departmentName: departmentName ?? '',
      yearNumber: yearNumber ?? 0,
      levelNumber: levelNumber ?? 0,
      createdOn: createdOn?.toIso8601String() ?? DateTime.now().toIso8601String(),
    );
  }
}
