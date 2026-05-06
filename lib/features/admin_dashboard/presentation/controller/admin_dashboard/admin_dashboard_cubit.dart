import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit() : super(AdminDashboardInitial());

  static AdminDashboardCubit get(BuildContext context) =>
      BlocProvider.of(context);

  AdminPage currentPage = AdminPage.dashboard;

  AdminPage selectedSidebarItem = AdminPage.dashboard;

  int dashboardTabIndex = 0;

  int? selectedCycleId;

  void changePage({required AdminPage page}) {
    currentPage = page;
    selectedSidebarItem = page;
    if (page == AdminPage.dashboard) {
      dashboardTabIndex = 0;
    }

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

  void changeDashboardTab(int index) {
    dashboardTabIndex = index;
    emit(AdminDashboardTabChanged());
  }

  String get currentPageTitle {
    switch (currentPage) {
      case AdminPage.dashboard:
        return 'dashboard';
      case AdminPage.users:
        return 'users';
      case AdminPage.cycles:
        return 'cycles';
      case AdminPage.cycleDetails:
        return 'cycleDetails';
    }
  }
}

enum AdminPage { dashboard, users, cycles, cycleDetails }
