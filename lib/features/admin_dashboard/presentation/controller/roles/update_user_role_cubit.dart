import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

sealed class UpdateUserRoleState {}

class UpdateUserRoleInitial extends UpdateUserRoleState {}

class UpdateUserRoleLoading extends UpdateUserRoleState {}

class UpdateUserRoleSuccess extends UpdateUserRoleState {
  final String message;
  UpdateUserRoleSuccess({required this.message});
}

class UpdateUserRoleFailure extends UpdateUserRoleState {
  final String errorMessage;
  UpdateUserRoleFailure({required this.errorMessage});
}

class UpdateUserRoleCubit extends Cubit<UpdateUserRoleState> {
  UpdateUserRoleCubit() : super(UpdateUserRoleInitial());

  Future<void> updateRole({required String userId, required String roleId}) async {
    emit(UpdateUserRoleLoading());
    try {
      final success = await RoleService.updateUserRole(userId: userId, roleId: roleId);
      if (success) {
        emit(UpdateUserRoleSuccess(message: 'User role updated successfully'));
      } else {
        emit(UpdateUserRoleFailure(errorMessage: 'Failed to update user role'));
      }
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      emit(UpdateUserRoleFailure(errorMessage: msg));
    }
  }
}
