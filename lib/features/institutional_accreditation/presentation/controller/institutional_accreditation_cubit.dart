import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class InstitutionalAccreditationCubit
    extends Cubit<InstitutionalAccreditationState> {
  InstitutionalAccreditationCubit()
    : super(InstitutionalAccreditationInitial());

  static InstitutionalAccreditationCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<AccreditationModel> institutionalAccreditations = [];
  AccreditationModel? selectedInstitutionalAccreditation;
  int? selectedYearId;

  void selectInstitutionalAccreditation({
    required AccreditationModel accreditation,
  }) {
    selectedInstitutionalAccreditation = accreditation;

    emit(
      InstitutionalAccreditationSuccess(
        accreditations: institutionalAccreditations,
        selectedAccreditation: selectedInstitutionalAccreditation,
      ),
    );
  }

  Future<void> fetchInstitutionalAccreditations({
    required int academicYearId,
    int? accreditationTypeId,
    bool isAdmin = true,
  }) async {
    emit(InstitutionalAccreditationLoading());

    try {
      final data = await AccreditationServices.getAccreditations(
        academicYearId: academicYearId,
        accreditationTypeId: accreditationTypeId,
        isAdmin: isAdmin,
      );
      institutionalAccreditations = data;
      emit(
        InstitutionalAccreditationSuccess(
          accreditations: institutionalAccreditations,
          selectedAccreditation: selectedInstitutionalAccreditation,
        ),
      );
    } catch (e) {
      final msg = e.toString();

      if (msg.contains('No Internet')) {
        emit(
          InstitutionalAccreditationError(
            message: 'Check your internet connection',
          ),
        );
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(
          InstitutionalAccreditationError(
            message: 'Session expired, please login again',
          ),
        );
      } else {
        emit(
          InstitutionalAccreditationError(
            message: msg.replaceFirst('Exception: ', '').trim(),
          ),
        );
      }
    }
  }

  void reset() {
    institutionalAccreditations = [];
    selectedInstitutionalAccreditation = null;
    emit(InstitutionalAccreditationInitial());
  }
}
