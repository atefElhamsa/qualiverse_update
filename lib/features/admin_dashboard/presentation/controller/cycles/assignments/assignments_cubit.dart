import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/assignment_indicator_admin_model.dart';
import 'package:qualiverse/features/admin_dashboard/data/service/assignment_indicator_admin_service.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignments_state.dart';

class AssignmentsCubit extends Cubit<AssignmentsState> {
  AssignmentsCubit() : super(AssignmentsInitial());

  static AssignmentsCubit get(BuildContext context) => BlocProvider.of(context);

  List<AssignmentIndicatorAdminModel> assignments = [];

  Future<void> fetchAssignments({
    required int academicYearId,
    String? doctorId,
    int? status,
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
