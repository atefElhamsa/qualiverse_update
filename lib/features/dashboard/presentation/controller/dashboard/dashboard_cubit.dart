import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/data/services/dashboard_services.dart';
import 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  final DashboardServices _dashboardServices = DashboardServices();

  DashboardCubit() : super(DashboardInitial());

  Future<void> getDashboard({
    int? yearId,
    int? departmentId,
    int? levelId,
    int? accreditationTypeId,
  }) async {
    emit(DashboardLoading());
    try {
      final result = await _dashboardServices.getDashboard(
        yearId: yearId,
        departmentId: departmentId,
        levelId: levelId,
        accreditationTypeId: accreditationTypeId,
      );
      if (result.data != null) {
        emit(DashboardSuccess(data: result.data!));
      } else {
        emit(DashboardFailure(errorMessage: 'Empty data received from server'));
      }
    } catch (e, stack) {
      debugPrint('Dashboard Error: $e');
      debugPrint('Stack Trace: $stack');
      emit(DashboardFailure(errorMessage: e.toString()));
    }
  }
}
