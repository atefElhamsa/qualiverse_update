import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class AcademicYearCubit extends Cubit<AcademicYearState> {
  AcademicYearCubit() : super(AcademicYearInitial());

  static AcademicYearCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<AcademicYearModel> academicYears = [];
  AcademicYearModel? selectedAcademicYear;

  void selectAcademicYear({required AcademicYearModel academicYear}) {
    selectedAcademicYear = academicYear;

    emit(
      AcademicYearSuccess(
        academicYears: academicYears,
        selectedAcademicYear: selectedAcademicYear,
      ),
    );
  }

  Future<void> fetchAcademicYears() async {
    emit(AcademicYearLoading());
    try {
      final data = await AcademicYearServices.getAcademicYears();
      academicYears = data;

      if (selectedAcademicYear != null) {
        selectedAcademicYear = academicYears.firstWhere(
          (e) => e.id == selectedAcademicYear!.id,
          orElse: () => academicYears.isNotEmpty
              ? academicYears.first
              : academicYears.first,
        );
      } else if (academicYears.isNotEmpty) {
        selectedAcademicYear = academicYears.first;
      }

      emit(
        AcademicYearSuccess(
          academicYears: academicYears,
          selectedAcademicYear: selectedAcademicYear,
        ),
      );
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();

      if (msg.contains('No Internet')) {
        emit(AcademicYearError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(AcademicYearError(message: 'Session expired, please login again'));
      } else {
        emit(AcademicYearError(message: msg));
      }
    }
  }

  Future<void> addAcademicYear({required int yearNumber}) async {
    emit(AcademicYearLoading());
    try {
      await AcademicYearServices.addAcademicYear(yearNumber: yearNumber);
      await fetchAcademicYears();
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      emit(AcademicYearAddedError(message: msg));
      emit(
        AcademicYearSuccess(
          academicYears: academicYears,
          selectedAcademicYear: selectedAcademicYear,
        ),
      );
    }
  }

  Future<void> deleteAcademicYear({required int id}) async {
    emit(AcademicYearLoading());
    try {
      final response = await AcademicYearServices.deleteAcademicYear(id: id);
      emit(AcademicYearDeleted(message: response.data!));
      await fetchAcademicYears();
    } catch (e) {
      final msg = e.toString().replaceFirst('Exception: ', '').trim();
      emit(AcademicYearDeleteError(message: msg));
      emit(
        AcademicYearSuccess(
          academicYears: academicYears,
          selectedAcademicYear: selectedAcademicYear,
        ),
      );
    }
  }

  void reset() {
    academicYears = [];
    selectedAcademicYear = null;
    emit(AcademicYearInitial());
  }
}
