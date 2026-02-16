import '../../../../routing/all_routes_imports.dart';

sealed class LevelState {}

final class LevelInitial extends LevelState {}

final class LevelLoading extends LevelState {}

final class LevelSuccess extends LevelState {
  final List<LevelModel> levels;
  final LevelModel? selectedLevel;

  LevelSuccess({required this.levels, this.selectedLevel});
}

final class LevelError extends LevelState {
  final String message;

  LevelError({required this.message});
}
