import '../../../../core/all_core_imports/all_core_imports.dart';

class CourseFolderResponse {
  final List<CourseFolderModel>? courseFolders;
  final bool isSuccess;
  final ApiErrorModel? error;

  CourseFolderResponse({
    this.courseFolders,
    required this.isSuccess,
    this.error,
  });

  factory CourseFolderResponse.fromJson(Map<String, dynamic> json) {
    return CourseFolderResponse(
      courseFolders: (json['data'] as List)
          .map((e) => CourseFolderModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class CourseFolderModel {
  final int id;
  final String name;

  CourseFolderModel({required this.id, required this.name});

  factory CourseFolderModel.fromJson(Map<String, dynamic> json) {
    return CourseFolderModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
