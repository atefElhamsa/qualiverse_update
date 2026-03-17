import '../../../../../routing/all_routes_imports.dart';

sealed class CourseFolderState {}

final class CourseFolderInitial extends CourseFolderState {}

final class CourseFolderLoading extends CourseFolderState {}

final class CourseFolderSuccess extends CourseFolderState {
  final List<CourseFolderModel> courseFolders;
  final CourseFolderModel? selectedCourseFolder;

  CourseFolderSuccess({required this.courseFolders, this.selectedCourseFolder});
}

final class CourseFolderError extends CourseFolderState {
  final String message;

  CourseFolderError({required this.message});
}
