import 'package:qualiverse/features/accreditation/accreditation_imports/accreditation_imports.dart';

sealed class TypesState {}

final class TypesInitial extends TypesState {}

final class TypesLoading extends TypesState {}

final class TypesSuccess extends TypesState {
  final List<TypeModel> types;
  final int selectedIndex;

  TypesSuccess({required this.types, required this.selectedIndex});
}

final class TypesError extends TypesState {
  final String message;

  TypesError({required this.message});
}
