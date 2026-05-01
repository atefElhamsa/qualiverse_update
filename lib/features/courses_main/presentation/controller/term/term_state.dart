import '../../../../../routing/all_routes_imports.dart';

sealed class TermState {}

final class TermInitial extends TermState {}

final class TermLoading extends TermState {}

final class TermSuccess extends TermState {
  final List<TermModel> terms;
  final TermModel? selectedTerm;

  TermSuccess({required this.terms, this.selectedTerm});
}

final class TermError extends TermState {
  final String message;

  TermError({required this.message});
}
