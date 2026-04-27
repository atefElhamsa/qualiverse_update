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
