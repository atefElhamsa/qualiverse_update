import '../../../../../routing/all_routes_imports.dart';

sealed class CourseState {}

final class CourseInitial extends CourseState {}

final class CourseLoading extends CourseState {}

final class CourseSuccess extends CourseState {
  final List<CourseModel> courses;
  final CourseModel? selectedCourse;

  CourseSuccess({required this.courses, this.selectedCourse});
}

final class CourseError extends CourseState {
  final String message;

  CourseError({required this.message});
}
