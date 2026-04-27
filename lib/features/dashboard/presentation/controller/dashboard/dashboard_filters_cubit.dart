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
    int? departmentId,
    int? levelId,
    int? accreditationTypeId,
    required DashboardCubit dashboardCubit,
  }) {
    if (yearId != null) this.yearId = yearId;
    if (departmentId != null) this.departmentId = departmentId;
    if (levelId != null) this.levelId = levelId;
    if (accreditationTypeId != null) this.accreditationTypeId = accreditationTypeId;

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
