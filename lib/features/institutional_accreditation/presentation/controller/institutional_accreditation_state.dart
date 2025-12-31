import '../../../../routing/all_routes_imports.dart';

sealed class InstitutionalAccreditationState {}

final class InstitutionalAccreditationInitial
    extends InstitutionalAccreditationState {}

final class InstitutionalAccreditationLoading
    extends InstitutionalAccreditationState {}

final class InstitutionalAccreditationSuccess
    extends InstitutionalAccreditationState {
  final List<AccreditationModel> accreditations;
  final AccreditationModel? selectedAccreditation;

  InstitutionalAccreditationSuccess({
    required this.accreditations,
    this.selectedAccreditation,
  });
}

final class InstitutionalAccreditationError
    extends InstitutionalAccreditationState {
  final String message;

  InstitutionalAccreditationError({required this.message});
}
