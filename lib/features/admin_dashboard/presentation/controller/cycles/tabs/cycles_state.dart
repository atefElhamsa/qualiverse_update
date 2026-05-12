import 'package:qualiverse/routing/all_routes_imports.dart';

abstract class CycleTabsState {}

class CycleTabsInitial extends CycleTabsState {}

class CycleTabsChanged extends CycleTabsState {
  final CycleTab tab;
  CycleTabsChanged({required this.tab});
}
