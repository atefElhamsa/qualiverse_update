import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../data/service/criterions_service.dart';
import 'criterions_state.dart';

class CriterionsCubit extends Cubit<CriterionsState> {
  CriterionsCubit() : super(CriterionsInitial());

  static CriterionsCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> fetchCriterions({
    required int academicYearId,
    int? accreditationTypeId,
    int? departmentId,
  }) async {
    emit(CriterionsLoading());
    try {
      final data = await CriterionsService.getCriterions(
        academicYearId: academicYearId,
        accreditationTypeId: accreditationTypeId,
        departmentId: departmentId,
      );
      emit(CriterionsSuccess(criterions: data));
    } catch (e) {
      emit(CriterionsError(message: e.toString()));
    }
  }

  Future<void> fetchTemplateCriteria({required int accreditationTypeId}) async {
    emit(CriterionsTemplatesLoading());
    try {
      final data = await CriterionsService.getTemplateCriteria(
        accreditationTypeId: accreditationTypeId,
      );
      emit(CriterionsTemplatesSuccess(templates: data));
    } catch (e) {
      emit(CriterionsError(message: e.toString()));
    }
  }

  Future<void> createCriterionFromExistingTemplate({
    required int criterionTemplateId,
    required int accreditationTypeId,
    required int departmentId,
    required int academicYearId,
  }) async {
    emit(CriterionsLoading());
    try {
      final message = await CriterionsService.createCriterionFromExistingTemplate(
        criterionTemplateId: criterionTemplateId,
        accreditationTypeId: accreditationTypeId,
        departmentId: departmentId,
        academicYearId: academicYearId,
      );
      emit(CriterionCreateSuccess(message: message));
    } catch (e) {
      emit(CriterionsError(message: e.toString()));
    }
  }

  Future<void> createNewCriterion({
    required String nameAr,
    required String nameEn,
    required int accreditationTypeId,
    required int departmentId,
    required int academicYearId,
  }) async {
    emit(CriterionsLoading());
    try {
      final message = await CriterionsService.createNewCriterion(
        nameAr: nameAr,
        nameEn: nameEn,
        accreditationTypeId: accreditationTypeId,
        departmentId: departmentId,
        academicYearId: academicYearId,
      );
      emit(CriterionCreateSuccess(message: message));
    } catch (e) {
      emit(CriterionsError(message: e.toString()));
    }
  }

  Future<void> toggleCriterionStatus({required int criterionId}) async {
    final currentState = state;
    if (currentState is CriterionsSuccess) {
      final updatedList = currentState.criterions.map((c) {
        if (c.id == criterionId) {
          return c.copyWith(isEnabled: !c.isEnabled);
        }
        return c;
      }).toList();

      emit(CriterionsSuccess(criterions: updatedList));

      try {
        await CriterionsService.toggleCriterionStatus(
          criterionId: criterionId,
        );
      } catch (e) {
        final revertedList = updatedList.map((c) {
          if (c.id == criterionId) {
            return c.copyWith(isEnabled: !c.isEnabled);
          }
          return c;
        }).toList();
        emit(CriterionsSuccess(criterions: revertedList));
        emit(CriterionsError(message: e.toString()));
      }
    }
  }
}
