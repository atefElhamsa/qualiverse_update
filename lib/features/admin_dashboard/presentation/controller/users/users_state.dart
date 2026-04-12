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

class ActivateDeactivateUserLoading extends ActivateDeactivateUserState {}

class ActivateDeactivateUserSuccess extends ActivateDeactivateUserState {
  final String message;

  ActivateDeactivateUserSuccess({required this.message});
}

class ActivateDeactivateUserFailure extends ActivateDeactivateUserState {
  final String error;

  ActivateDeactivateUserFailure({required this.error});
}

class DeleteUserState extends UsersState {}

class DeleteUserLoading extends DeleteUserState {}

class DeleteUserSuccess extends DeleteUserState {
  final String message;

  DeleteUserSuccess({required this.message});
}

class DeleteUserFailure extends DeleteUserState {
  final String error;

  DeleteUserFailure({required this.error});
}
