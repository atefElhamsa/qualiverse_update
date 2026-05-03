import 'package:qualiverse/features/admin_dashboard/data/model/role_model.dart';

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
