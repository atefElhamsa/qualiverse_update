import 'package:qualiverse/features/admin_dashboard/presentation/controller/cycles/tabs/cycles_cubit.dart';

abstract class CycleTabsState {}

class CycleTabsInitial extends CycleTabsState {}

class CycleTabsChanged extends CycleTabsState {
  final CycleTab tab;
  CycleTabsChanged({required this.tab});
}
