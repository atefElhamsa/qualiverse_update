import '../../../../routing/all_routes_imports.dart';

sealed class DepartmentState {}

final class DepartmentInitial extends DepartmentState {}

final class DepartmentLoading extends DepartmentState {}

final class DepartmentSuccess extends DepartmentState {
  final List<DepartmentModel> departments;
  final DepartmentModel? selectedDepartment;

  DepartmentSuccess({required this.departments, this.selectedDepartment});
}

final class DepartmentError extends DepartmentState {
  final String message;

  DepartmentError({required this.message});
}
