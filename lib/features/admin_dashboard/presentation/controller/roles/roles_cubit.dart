import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class RolesCubit extends Cubit<RolesState> {
  RolesCubit() : super(RolesInitial());

  static RolesCubit get(BuildContext context) => BlocProvider.of(context);

  List<RoleModel> roles = [];
  

  Future<void> getRoles() async {
    emit(RolesLoading());
    try {
      final data = await RoleService.getRoles();
      emit(RolesSuccess(roles: data.roles!));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();

      if (msg.contains('No Internet')) {
        emit(RolesFailure(errorMessage: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        emit(RolesFailure(errorMessage: 'Session expired, please login again'));
      } else {
        emit(RolesFailure(errorMessage: msg));
      }
    }
  }
}
