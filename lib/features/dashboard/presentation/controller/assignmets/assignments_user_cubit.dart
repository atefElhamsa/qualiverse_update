import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/data/services/assignments_user_service.dart';
import 'assignments_user_state.dart';

class AssignmentsUserCubit extends Cubit<AssignmentsUserState> {
  final AssignmentsUserService _service = AssignmentsUserService();

  AssignmentsUserCubit() : super(AssignmentsUserInitial());

  Future<void> getAssignments({
    required int academicYearId,
    int? status,
  }) async {
    emit(AssignmentsUserLoading());
    try {
      final result = await _service.getAssignmentsUser(
        academicYearId: academicYearId,
        status: status,
      );

      if (result.data != null) {
        emit(AssignmentsUserSuccess(assignments: result.data!));
      } else {
        emit(AssignmentsUserSuccess(assignments: const []));
      }
    } catch (e, stack) {
      debugPrint('AssignmentsUser Error: $e');
      debugPrint('Stack Trace: $stack');
      emit(
        AssignmentsUserFailure(
          errorMessage: e.toString().replaceAll('Exception: ', ''),
        ),
      );
    }
  }
}
