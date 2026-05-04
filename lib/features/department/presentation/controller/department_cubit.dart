import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  static DepartmentCubit get(BuildContext context) => BlocProvider.of(context);

  List<DepartmentModel> departments = [];
  DepartmentModel? selectedDepartment;

  void selectDepartment({DepartmentModel? department}) {
    selectedDepartment = department;

    emit(
      DepartmentSuccess(
        departments: departments,
        selectedDepartment: selectedDepartment,
      ),
    );
  }

  Future<void> fetchDepartments() async {
    emit(DepartmentLoading());
    try {
      final data = await DepartmentService.getDepartments();
      departments = data;
      
      if (selectedDepartment == null && departments.isNotEmpty) {
        selectedDepartment = departments.first;
      }

      emit(
        DepartmentSuccess(
          departments: departments,
          selectedDepartment: selectedDepartment,
        ),
      );
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();

      if (msg.contains('No Internet')) {
        emit(DepartmentError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(DepartmentError(message: 'Session expired, please login again'));
      } else {
        emit(DepartmentError(message: msg));
      }
    }
  }

  void reset() {
    departments = [];
    selectedDepartment = null;
    emit(DepartmentSuccess(departments: departments));
  }
}
