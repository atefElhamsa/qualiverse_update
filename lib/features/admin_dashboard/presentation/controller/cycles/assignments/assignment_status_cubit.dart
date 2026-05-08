import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/data/model/assignment_state_model.dart';
import 'package:qualiverse/features/admin_dashboard/data/service/assignment_status_service.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/assignments/assignment_status_state.dart';

class AssignmentStatusCubit extends Cubit<AssignmentStatusState> {
  AssignmentStatusCubit() : super(AssignmentStatusInitial());

  static AssignmentStatusCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<AssignmentStateModel> statuses = [];
  AssignmentStateModel? selectedStatus;

  Future<void> fetchStatuses() async {
    emit(AssignmentStatusLoading());
    try {
      final response = await AssignmentStatusService.getAssignmentStatuses();
      statuses = response.data;
      if (selectedStatus != null) {
        selectedStatus = statuses.firstWhere(
          (e) => e.value == selectedStatus!.value,
          orElse: () => statuses.isNotEmpty ? statuses.first : statuses.first,
        );
      } else if (statuses.isNotEmpty) {
        selectedStatus = statuses.first;
      }
      emit(AssignmentStatusSuccess(statuses: statuses));
    } catch (e) {
      emit(AssignmentStatusError(error: e.toString()));
    }
  }

  void selectStatus(AssignmentStateModel? status) {
    selectedStatus = status;
    emit(AssignmentStatusSuccess(statuses: statuses));
  }

  void resetSelection() {
    selectedStatus = null;
    emit(AssignmentStatusSuccess(statuses: statuses));
  }
}
