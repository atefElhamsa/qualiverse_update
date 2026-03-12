import '../../../../core/all_core_imports/all_core_imports.dart';

class CoursesResponseModel {
  final List<CourseModel>? courses;
  final bool isSuccess;
  final ApiErrorModel? error;

  CoursesResponseModel({this.courses, required this.isSuccess, this.error});

  factory CoursesResponseModel.fromJson(Map<String, dynamic> json) {
    return CoursesResponseModel(
      courses: (json['data'] as List)
          .map((e) => CourseModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'] ?? false,
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class CourseModel {
  final int id;
  final int courseTemplateId;
  final String code;
  final String name;
  final int levelId;
  final int semesterId;
  final int academicYearId;
  final int? departmentId;

  CourseModel({
    required this.id,
    required this.courseTemplateId,
    required this.code,
    required this.name,
    required this.levelId,
    required this.semesterId,
    required this.academicYearId,
    this.departmentId,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as int,
      courseTemplateId: json['courseTemplateId'] as int,
      code: json['code'] as String,
      name: json['name'] as String,
      levelId: json['levelId'] as int,
      semesterId: json['semesterId'] as int,
      academicYearId: json['academicYearId'] as int,
      departmentId: json['departmentId'] as int?,
    );
  }
}
