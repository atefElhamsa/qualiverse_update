import 'package:qualiverse/routing/all_routes_imports.dart';

class CourseArgs {
  final int yearId;
  final int levelId;
  final int departmentId;
  final SemesterModel semesterModel;

  CourseArgs({
    required this.yearId,
    required this.levelId,
    required this.semesterModel,
    required this.departmentId,
  });
}
