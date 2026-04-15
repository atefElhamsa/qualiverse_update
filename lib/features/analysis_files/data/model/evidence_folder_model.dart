import '../../../../core/all_core_imports/all_core_imports.dart';

class EvidenceFolderResponse {
  final bool isSuccess;
  final List<EvidenceFolderModel>? data;
  final ApiErrorModel? error;

  EvidenceFolderResponse({required this.isSuccess, this.data, this.error});

  factory EvidenceFolderResponse.fromJson(Map<String, dynamic> json) {
    return EvidenceFolderResponse(
      isSuccess: json['isSuccess'] ?? false,
      data: (json['data'] as List?)
          ?.map((e) => EvidenceFolderModel.fromJson(e))
          .toList(),
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class EvidenceFolderModel {
  final int id;
  final String name;
  final String description;

  EvidenceFolderModel({
    required this.id,
    required this.name,
    required this.description,
  });

  factory EvidenceFolderModel.fromJson(Map<String, dynamic> json) {
    return EvidenceFolderModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
