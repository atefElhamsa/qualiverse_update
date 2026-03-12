import '../../../../../routing/all_routes_imports.dart';

sealed class SemesterState {}

final class SemesterInitial extends SemesterState {}

final class SemesterLoading extends SemesterState {}

final class SemesterSuccess extends SemesterState {
  final List<SemesterModel> semesters;
  final SemesterModel? selectedSemester;

  SemesterSuccess({required this.semesters, this.selectedSemester});
}

final class SemesterError extends SemesterState {
  final String message;

  SemesterError({required this.message});
}
