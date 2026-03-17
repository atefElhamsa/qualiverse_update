import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class SemesterCubit extends Cubit<SemesterState> {
  SemesterCubit() : super(SemesterInitial());

  static SemesterCubit get(BuildContext context) => BlocProvider.of(context);

  List<SemesterModel> semesters = [];
  SemesterModel? selectedSemester;

  void selectSemester({required SemesterModel semester}) {
    selectedSemester = semester;
    emit(
      SemesterSuccess(semesters: semesters, selectedSemester: selectedSemester),
    );
  }

  Future<void> fetchSemesters() async {
    emit(SemesterLoading());
    try {
      final data = await SemesterService.getSemesters();
      semesters = data;
      emit(
        SemesterSuccess(
          semesters: semesters,
          selectedSemester: selectedSemester,
        ),
      );
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(SemesterError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(SemesterError(message: 'Session expired, please login again'));
      } else {
        emit(SemesterError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    semesters = [];
    selectedSemester = null;
    emit(SemesterInitial());
  }
}
