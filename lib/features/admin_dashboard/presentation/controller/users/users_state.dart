import '../../../../../routing/all_routes_imports.dart';

sealed class UsersState {}

class UsersInitial extends UsersState {}

class UsersLoading extends UsersState {}

class UsersSuccess extends UsersState {
  final List<UserManagementModel> users;

  UsersSuccess({required this.users});
}

class UsersFailure extends UsersState {
  final String error;

  UsersFailure({required this.error});
}

class ActivateDeactivateUserState extends UsersState {}

// class ActivateDeactivateUserInitial extends ActivateDeactivateUserState {}

class ActivateDeactivateUserLoading extends ActivateDeactivateUserState {}

class ActivateDeactivateUserSuccess extends ActivateDeactivateUserState {
  final String message;

  ActivateDeactivateUserSuccess({required this.message});
}

class ActivateDeactivateUserFailure extends ActivateDeactivateUserState {
  final String error;

  ActivateDeactivateUserFailure({required this.error});
}
