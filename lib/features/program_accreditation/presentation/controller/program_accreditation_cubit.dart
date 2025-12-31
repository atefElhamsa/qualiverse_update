import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class ProgramAccreditationCubit extends Cubit<ProgramAccreditationState> {
  ProgramAccreditationCubit() : super(ProgramAccreditationInitial());

  static ProgramAccreditationCubit get(context) => BlocProvider.of(context);

  List<AccreditationModel> programAccreditations = [];
  AccreditationModel? selectedProgramAccreditation;

  void selectProgramAccreditation({required AccreditationModel accreditation}) {
    selectedProgramAccreditation = accreditation;

    emit(
      ProgramAccreditationSuccess(
        accreditations: programAccreditations,
        selectedAccreditation: selectedProgramAccreditation,
      ),
    );
  }

  Future<void> fetchProgramAccreditations({
    required int academicYearId,
    int? departmentId,
  }) async {
    emit(ProgramAccreditationLoading());

    try {
      final data = await AccreditationServices.getAccreditations(
        academicYearId: academicYearId,
        departmentId: departmentId,
      );
      programAccreditations = data;
      emit(
        ProgramAccreditationSuccess(
          accreditations: programAccreditations,
          selectedAccreditation: selectedProgramAccreditation,
        ),
      );
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(
          ProgramAccreditationError(message: 'Check your internet connection'),
        );
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(
          ProgramAccreditationError(
            message: 'Session expired, please login again',
          ),
        );
      } else {
        emit(ProgramAccreditationError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    programAccreditations = [];
    selectedProgramAccreditation = null;
    emit(ProgramAccreditationInitial());
  }
}
