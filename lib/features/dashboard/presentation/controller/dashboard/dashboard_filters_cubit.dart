import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/dashboard/presentation/controller/dashboard/dashboard_cubit.dart';

class DashboardFiltersCubit extends Cubit<DashboardFiltersState> {
  DashboardFiltersCubit() : super(DashboardFiltersInitial());

  int? yearId;
  int? departmentId;
  int? levelId;
  int? accreditationTypeId;

  void updateFilters({
    int? yearId,
    bool clearYear = false,
    int? departmentId,
    bool clearDepartment = false,
    int? levelId,
    bool clearLevel = false,
    int? accreditationTypeId,
    bool clearAccreditation = false,
    required DashboardCubit dashboardCubit,
  }) {
    if (clearYear) {
      this.yearId = null;
    } else if (yearId != null) {
      this.yearId = yearId;
    }

    if (clearDepartment) {
      this.departmentId = null;
    } else if (departmentId != null) {
      this.departmentId = departmentId;
    }

    if (clearLevel) {
      this.levelId = null;
    } else if (levelId != null) {
      this.levelId = levelId;
    }

    if (clearAccreditation) {
      this.accreditationTypeId = null;
    } else if (accreditationTypeId != null) {
      this.accreditationTypeId = accreditationTypeId;
    }

    emit(DashboardFiltersUpdated());

    // Trigger dashboard refresh with new filters
    dashboardCubit.getDashboard(
      yearId: this.yearId,
      departmentId: this.departmentId,
      levelId: this.levelId,
      accreditationTypeId: this.accreditationTypeId,
    );
  }
}

abstract class DashboardFiltersState {}

class DashboardFiltersInitial extends DashboardFiltersState {}

class DashboardFiltersUpdated extends DashboardFiltersState {}
