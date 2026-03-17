import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../routing/all_routes_imports.dart';

class CourseFolderCubit extends Cubit<CourseFolderState> {
  CourseFolderCubit() : super(CourseFolderInitial());

  static CourseFolderCubit get(BuildContext context) =>
      BlocProvider.of(context);

  List<CourseFolderModel> courseFolders = [];
  CourseFolderModel? selectedCourseFolder;
  int? currentCourseId;

  void selectCourseFolder({required CourseFolderModel courseFolder}) {
    selectedCourseFolder = courseFolder;

    emit(
      CourseFolderSuccess(
        courseFolders: courseFolders,
        selectedCourseFolder: selectedCourseFolder,
      ),
    );
  }

  Future<void> fetchCourseFolders({required int courseId}) async {
    currentCourseId = courseId;
    emit(CourseFolderLoading());
    try {
      final data = await CourseFolderService.getCourseFolders(
        courseId: courseId,
      );
      courseFolders = data;
      emit(
        CourseFolderSuccess(
          courseFolders: courseFolders,
          selectedCourseFolder: selectedCourseFolder,
        ),
      );
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(CourseFolderError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(CourseFolderError(message: 'Session expired, please login again'));
      } else {
        emit(CourseFolderError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    courseFolders = [];
    selectedCourseFolder = null;
    emit(CourseFolderInitial());
  }
}
