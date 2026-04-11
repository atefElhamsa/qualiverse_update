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
      users = data;
      emit(UsersSuccess(users: users));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(UsersFailure(error: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        reset();
      } else {
        emit(UsersFailure(error: 'Something went wrong'));
      }
    }
  }

  Future<void> activateUser({required String id}) async {
    emit(ActivateDeactivateUserLoading());
    try {
      final data = await UsersService.activateUser(id: id);
      emit(ActivateDeactivateUserSuccess(message: data));
    } catch (e) {
      final msg = e.toString();
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
        emit(ActivateDeactivateUserFailure(error: 'Something went wrong'));
      }
    }
  }

  Future<void> deactivateUser({required String id}) async {
    emit(ActivateDeactivateUserLoading());
    try {
      final data = await UsersService.deactivateUser(id: id);
      emit(ActivateDeactivateUserSuccess(message: data));
    } catch (e) {
      final msg = e.toString();
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
        emit(ActivateDeactivateUserFailure(error: 'Something went wrong'));
      }
    }
  }

  void reset() {
    users = [];
    emit(UsersInitial());
  }
}
