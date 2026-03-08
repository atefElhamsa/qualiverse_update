import '../../../../routing/all_routes_imports.dart';

sealed class CoursesPerDepartmentState {}

class CoursesPerDepartmentInitial extends CoursesPerDepartmentState {}

class CoursesPerDepartmentLoaded extends CoursesPerDepartmentState {
  final List<DepartmentDataModel> data;

  CoursesPerDepartmentLoaded({required this.data});
}
