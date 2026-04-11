import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class AdminDashboardCubit extends Cubit<AdminDashboardState> {
  AdminDashboardCubit() : super(AdminDashboardInitial());

  static AdminDashboardCubit get(BuildContext context) =>
      BlocProvider.of(context);

  int selectedIndex = 0;

  void changeIndex(int index) {
    selectedIndex = index;
    emit(AdminDashboardInitial());
  }
}
