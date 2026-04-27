import 'package:qualiverse/routing/all_routes_imports.dart';

class CycleCoursesResponseModel {
  final List<CourseItemModel>? courses;
  final bool isSuccess;
  final ApiErrorModel? error;

  CycleCoursesResponseModel({
    this.courses,
    required this.isSuccess,
    this.error,
  });

  factory CycleCoursesResponseModel.fromJson(Map<String, dynamic> json) {
    return CycleCoursesResponseModel(
      courses: (json['data'] as List)
          .map((e) => CourseItemModel.fromJson(e))
          .toList(),
      isSuccess: json['isSuccess'],
      error: json['error'] != null
          ? ApiErrorModel.fromJson(json['error'])
          : null,
    );
  }
}

class CourseItemModel {
  final int courseId;
  final String name;
  final String code;
  final DepartmentCourseItemModel department;
  final LevelCourseItemModel level;
  final SemesterCourseItemModel semester;
  final String doctor;

  const CourseItemModel({
    required this.courseId,
    required this.name,
    required this.code,
    required this.department,
    required this.level,
    required this.semester,
    required this.doctor,
  });

  factory CourseItemModel.fromJson(Map<String, dynamic> json) {
    return CourseItemModel(
      courseId: json['id'] as int,
      name: json['name'] as String,
      code: json['code'] as String,
      department: DepartmentCourseItemModel.fromJson(
        json['department'] as Map<String, dynamic>,
      ),
      level: LevelCourseItemModel.fromJson(
        json['level'] as Map<String, dynamic>,
      ),
      semester: SemesterCourseItemModel.fromJson(
        json['semester'] as Map<String, dynamic>,
      ),
      doctor: json['assignedDoctor'] != null
          ? (json['assignedDoctor'] as Map<String, dynamic>)['name'] as String
          : '-',
    );
  }

  bool get isAssigned => doctor != '-';
}

class DepartmentCourseItemModel {
  final int id;
  final String name;

  DepartmentCourseItemModel({required this.id, required this.name});

  factory DepartmentCourseItemModel.fromJson(Map<String, dynamic> json) {
    return DepartmentCourseItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class LevelCourseItemModel {
  final int id;
  final String name;

  LevelCourseItemModel({required this.id, required this.name});

  factory LevelCourseItemModel.fromJson(Map<String, dynamic> json) {
    return LevelCourseItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}

class SemesterCourseItemModel {
  final int id;
  final String name;

  SemesterCourseItemModel({required this.id, required this.name});

  factory SemesterCourseItemModel.fromJson(Map<String, dynamic> json) {
    return SemesterCourseItemModel(
      id: json['id'] as int,
      name: json['name'] as String,
    );
  }
}
