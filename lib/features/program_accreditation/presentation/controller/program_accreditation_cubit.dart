import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class ProgramAccreditationCubit extends Cubit<ProgramAccreditationState> {
  ProgramAccreditationCubit() : super(ProgramAccreditationInitial());

  static ProgramAccreditationCubit get(BuildContext context) =>
      BlocProvider.of(context);

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
    int? accreditationTypeId,
    bool isAdmin = true,
  }) async {
    emit(ProgramAccreditationLoading());
    try {
      final data = await AccreditationServices.getAccreditations(
        academicYearId: academicYearId,
        departmentId: departmentId,
        accreditationTypeId: accreditationTypeId,
        isAdmin: isAdmin,
      );

      final Map<String, AccreditationModel> uniqueMap = {};
      for (var item in data) {
        uniqueMap[item.name] = item;
      }
      programAccreditations = uniqueMap.values.toList();

      if (programAccreditations.isNotEmpty) {
        selectedProgramAccreditation = programAccreditations.first;
      } else {
        selectedProgramAccreditation = null;
      }
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
        emit(ProgramAccreditationError(message: msg.replaceFirst('Exception: ', '').trim()));
      }
    }
  }

  void reset() {
    programAccreditations = [];
    selectedProgramAccreditation = null;
    emit(ProgramAccreditationInitial());
  }
}
