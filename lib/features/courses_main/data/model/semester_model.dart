import '../../../../core/all_core_imports/all_core_imports.dart';

class SemesterResponseModel {
  final List<SemesterModel>? semesters;
  final bool isSuccess;
  final ApiErrorModel? error;

  SemesterResponseModel({required this.isSuccess, this.semesters, this.error});

  factory SemesterResponseModel.fromJson(Map<String, dynamic> json) {
    return SemesterResponseModel(
      semesters: (json['data'] as List)
          .map((e) => SemesterModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class SemesterModel {
  final int id;
  final int semesterNumber;
  final String name;

  const SemesterModel({
    required this.id,
    required this.semesterNumber,
    required this.name,
  });

  factory SemesterModel.fromJson(Map<String, dynamic> json) => SemesterModel(
    id: json['id'] as int,
    semesterNumber: json['semesterNumber'] as int,
    name: json['name'] as String,
  );
}
