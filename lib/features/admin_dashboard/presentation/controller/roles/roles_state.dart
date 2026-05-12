import 'package:qualiverse/routing/all_routes_imports.dart';

sealed class RolesState {}

class RolesInitial extends RolesState {}

class RolesLoading extends RolesState {}

class RolesSuccess extends RolesState {
  final List<RoleModel> roles;
  RolesSuccess({required this.roles});
}

class RolesFailure extends RolesState {
  final String errorMessage;
  RolesFailure({required this.errorMessage});
}
