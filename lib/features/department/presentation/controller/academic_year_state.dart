import '../../../../routing/all_routes_imports.dart';

sealed class AcademicYearState {}

final class AcademicYearInitial extends AcademicYearState {}

final class AcademicYearLoading extends AcademicYearState {}

final class AcademicYearSuccess extends AcademicYearState {
  final List<AcademicYearModel> academicYears;
  final AcademicYearModel? selectedAcademicYear;

  AcademicYearSuccess({required this.academicYears, this.selectedAcademicYear});
}

final class AcademicYearError extends AcademicYearState {
  final String message;

  AcademicYearError({required this.message});
}
