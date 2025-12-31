import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class AcademicYearCubit extends Cubit<AcademicYearState> {
  AcademicYearCubit() : super(AcademicYearInitial());

  static AcademicYearCubit get(context) => BlocProvider.of(context);

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

      emit(
        AcademicYearSuccess(
          academicYears: academicYears,
          selectedAcademicYear: selectedAcademicYear,
        ),
      );
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(AcademicYearError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(AcademicYearError(message: 'Session expired, please login again'));
      } else {
        emit(AcademicYearError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    academicYears = [];
    selectedAcademicYear = null;
    emit(AcademicYearInitial());
  }
}
