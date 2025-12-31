import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class DepartmentCubit extends Cubit<DepartmentState> {
  DepartmentCubit() : super(DepartmentInitial());

  static DepartmentCubit get(context) => BlocProvider.of(context);

  List<DepartmentModel> departments = [];
  DepartmentModel? selectedDepartment;

  void selectDepartment({required DepartmentModel department}) {
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

      emit(
        DepartmentSuccess(
          departments: departments,
          selectedDepartment: selectedDepartment,
        ),
      );
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(DepartmentError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(DepartmentError(message: 'Session expired, please login again'));
      } else {
        emit(DepartmentError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    departments = [];
    selectedDepartment = null;
    emit(DepartmentInitial());
  }
}
