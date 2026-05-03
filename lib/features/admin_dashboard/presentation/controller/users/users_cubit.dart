import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersInitial());

  static UsersCubit get(BuildContext context) => BlocProvider.of(context);

  List<UserManagementModel> users = [];

  Future<void> fetchUsers() async {
    emit(UsersLoading());
    try {
      final data = await UsersService.getUsers();
      users = data.data!;
      emit(UsersSuccess(users: users));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.contains('No Internet')) {
        emit(UsersFailure(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(UsersFailure(error: msg));
      }
    }
  }

  Future<void> activateUser({required String id}) async {
    emit(ActivateDeactivateUserLoading());
    try {
      final data = await UsersService.activateUser(id: id);
      emit(ActivateDeactivateUserSuccess(message: data));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.contains('No Internet')) {
        emit(
          ActivateDeactivateUserFailure(
            error: 'Check your internet connection',
          ),
        );
      }
      if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(ActivateDeactivateUserFailure(error: msg));
      }
    }
  }

  Future<void> deactivateUser({required String id}) async {
    emit(ActivateDeactivateUserLoading());
    try {
      final data = await UsersService.deactivateUser(id: id);
      emit(ActivateDeactivateUserSuccess(message: data));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.contains('No Internet')) {
        emit(
          ActivateDeactivateUserFailure(
            error: 'Check your internet connection',
          ),
        );
      }
      if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(ActivateDeactivateUserFailure(error: msg));
      }
    }
  }

  Future<void> deleteUser({required String id}) async {
    emit(DeleteUserLoading());
    try {
      final data = await UsersService.deleteUser(id: id);
      emit(DeleteUserSuccess(message: data));
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      if (msg.contains('No Internet')) {
        emit(DeleteUserFailure(error: 'Check your internet connection'));
      }
      if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(DeleteUserFailure(error: msg));
      }
    }
  }

  void reset() {
    users = [];
    emit(UsersInitial());
  }
}
