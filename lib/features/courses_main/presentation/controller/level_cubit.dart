import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class LevelCubit extends Cubit<LevelState> {
  LevelCubit() : super(LevelInitial());

  static LevelCubit get(context) => BlocProvider.of(context);

  List<LevelModel> levels = [];
  LevelModel? selectedLevel;

  void selectLevel({required LevelModel level}) {
    selectedLevel = level;
    emit(LevelSuccess(levels: levels, selectedLevel: selectedLevel));
  }

  Future<void> fetchLevels() async {
    emit(LevelLoading());
    try {
      final data = await CoursesMainServices.getLevels();
      levels = data;
      emit(LevelSuccess(levels: levels, selectedLevel: selectedLevel));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(LevelError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(LevelError(message: 'Session expired, please login again'));
      } else {
        emit(LevelError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    levels = [];
    selectedLevel = null;
    emit(LevelInitial());
  }
}
