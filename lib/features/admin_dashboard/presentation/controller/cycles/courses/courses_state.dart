import '../../../../../../routing/all_routes_imports.dart';

sealed class CoursesState {}

final class CoursesInitial extends CoursesState {}

final class CoursesLoading extends CoursesState {}

final class CoursesSuccess extends CoursesState {
  final List<CourseItemModel> courses;

  CoursesSuccess({required this.courses});
}

final class CoursesFailure extends CoursesState {
  final String error;

  CoursesFailure({required this.error});
}

final class DeleteCourseLoading extends CoursesState {}

final class DeleteCourseSuccess extends CoursesState {
  final String message;

  DeleteCourseSuccess({required this.message});
}

final class DeleteCourseFailure extends CoursesState {
  final String error;

  DeleteCourseFailure({required this.error});
}

final class UpdateCourseLoading extends CoursesState {}

final class UpdateCourseSuccess extends CoursesState {
  final String message;

  UpdateCourseSuccess({required this.message});
}

final class UpdateCourseFailure extends CoursesState {
  final String error;

  UpdateCourseFailure({required this.error});
}
