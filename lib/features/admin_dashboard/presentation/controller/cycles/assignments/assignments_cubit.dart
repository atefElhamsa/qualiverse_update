import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AssignmentsCubit extends Cubit<AssignmentsState> {
  AssignmentsCubit() : super(AssignmentsInitial());

  static AssignmentsCubit get(BuildContext context) => BlocProvider.of(context);

  List<AssignmentIndicatorAdminModel> assignments = [];

  Future<void> fetchAssignments({
    required int academicYearId,
    String? doctorId,
    String? status,
  }) async {
    emit(AssignmentsLoading());
    try {
      final response =
          await AssignmentIndicatorAdminService.getAssignmentIndicatorsAdmin(
            academicYearId: academicYearId,
            doctorId: doctorId,
            status: status,
          );
      assignments = response.data!;
      emit(AssignmentsLoaded(assignments: assignments));
    } catch (e) {
      emit(AssignmentsError(error: e.toString()));
    }
  }

  void reset() {
    assignments = [];
    emit(AssignmentsInitial());
  }
}
