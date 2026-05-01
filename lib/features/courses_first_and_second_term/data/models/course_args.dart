import 'package:qualiverse/routing/all_routes_imports.dart';

class CourseArgs {
  final int yearId;
  final int levelId;
  final int? departmentId;
  final TermModel termModel;

  CourseArgs({
    required this.yearId,
    required this.levelId,
    required this.termModel,
    this.departmentId,
  });
}
