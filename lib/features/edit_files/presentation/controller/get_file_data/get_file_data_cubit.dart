import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class GetFileDataCubit extends Cubit<GetFileDataState> {
  GetFileDataCubit() : super(GetFileDataInitial());

  static GetFileDataCubit get(BuildContext context) => BlocProvider.of(context);

  Future<void> getFileData({
    required int courseId,
    required int academicYearId,
    required int termId,
    required int levelId,
    int? departmentId,
  }) async {
    try {
      emit(GetFileDataLoading());
      final response = await GetFileDataService.getFileData(
        courseId: courseId,
        academicYearId: academicYearId,
        termId: termId,
        levelId: levelId,
        departmentId: departmentId,
      );
      emit(GetFileDataSuccess(data: response.data!));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(
          GetFileDataFailure(errorMessage: 'Check your internet connection'),
        );
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        emit(
          GetFileDataFailure(
            errorMessage: 'Session expired, please login again',
          ),
        );
      } else {
        emit(
          GetFileDataFailure(
            errorMessage: msg.replaceFirst('Exception: ', '').trim(),
          ),
        );
      }
    }
  }
}
