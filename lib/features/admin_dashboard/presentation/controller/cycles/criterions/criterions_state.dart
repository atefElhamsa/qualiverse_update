import '../../../../admin_dashboard_imports/admin_dashboard_imports.dart';

sealed class CriterionsState {}

final class CriterionsInitial extends CriterionsState {}

final class CriterionsLoading extends CriterionsState {}

final class CriterionsSuccess extends CriterionsState {
  final List<CriterionItemModel> criterions;

  CriterionsSuccess({required this.criterions});
}

final class CriterionsTemplatesSuccess extends CriterionsState {
  final List<CriterionTemplateModel> templates;

  CriterionsTemplatesSuccess({required this.templates});
}

final class CriterionsTemplatesLoading extends CriterionsState {}

final class CriterionCreateSuccess extends CriterionsState {
  final String message;

  CriterionCreateSuccess({required this.message});
}

final class CriterionsError extends CriterionsState {
  final String message;

  CriterionsError({required this.message});
}
