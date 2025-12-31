import '../../../../routing/all_routes_imports.dart';

sealed class ProgramAccreditationState {}

final class ProgramAccreditationInitial extends ProgramAccreditationState {}

final class ProgramAccreditationLoading extends ProgramAccreditationState {}

final class ProgramAccreditationSuccess extends ProgramAccreditationState {
  final List<AccreditationModel> accreditations;
  final AccreditationModel? selectedAccreditation;

  ProgramAccreditationSuccess({
    required this.accreditations,
    this.selectedAccreditation,
  });
}

final class ProgramAccreditationError extends ProgramAccreditationState {
  final String message;

  ProgramAccreditationError({required this.message});
}
