import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit() : super(AdminDashboardInitial());

  static AdminDashboardCubit get(BuildContext context) =>
      BlocProvider.of(context);

  AdminPage currentPage = AdminPage.dashboard;

  AdminPage selectedSidebarItem = AdminPage.dashboard;

  int? selectedCycleId;

  void changePage({required AdminPage page}) {
    currentPage = page;
    selectedSidebarItem = page;

    emit(AdminDashboardPageChanged());
  }

  void openCycleDetails({required int cycleId}) {
    selectedCycleId = cycleId;

    currentPage = AdminPage.cycleDetails;

    selectedSidebarItem = AdminPage.cycles;

    emit(AdminDashboardPageChanged());
  }

  void backToCycles() {
    currentPage = AdminPage.cycles;
    selectedSidebarItem = AdminPage.cycles;

    emit(AdminDashboardPageChanged());
  }
}

enum AdminPage {
  dashboard,
  users,
  cycles,
  standards,
  accreditation,
  auditLog,
  settings,
  cycleDetails,
}
