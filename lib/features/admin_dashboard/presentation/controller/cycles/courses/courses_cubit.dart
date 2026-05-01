import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/features/admin_dashboard/data/service/cycles_courses_service.dart';
import 'courses_state.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  static CoursesCubit get(BuildContext context) => BlocProvider.of(context);

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> getCourses({
    required int academicYearId,
    required int departmentId,
    required int levelId,
    required int termId,
  }) async {
    if (!await checkInternet()) {
      emit(CoursesFailure(error: "checkInternet".tr()));
      return;
    }
    emit(CoursesLoading());
    try {
      final result = await CyclesCoursesService.getCourses(
        academicYearId: academicYearId,
        departmentId: departmentId,
        levelId: levelId,
        termId: termId,
      );
      emit(CoursesSuccess(courses: result));
    } catch (e) {
      emit(
        CoursesFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  Future<void> deleteCourseEntirely({required int courseId}) async {
    if (!await checkInternet()) {
      emit(DeleteCourseFailure(error: "checkInternet".tr()));
      return;
    }
    emit(DeleteCourseLoading());
    try {
      final result = await CyclesCoursesService.deleteCourse(courseId: courseId);
      emit(DeleteCourseSuccess(message: result));
    } catch (e) {
      emit(
        DeleteCourseFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
