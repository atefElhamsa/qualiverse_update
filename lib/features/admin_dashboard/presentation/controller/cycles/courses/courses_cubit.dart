import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesCubit extends Cubit<CoursesState> {
  CoursesCubit() : super(CoursesInitial());

  static CoursesCubit get(BuildContext context) => BlocProvider.of(context);

  Future<bool> checkInternet() async {
    final conn = await Connectivity().checkConnectivity();
    return conn != ConnectivityResult.none;
  }

  Future<void> getCourses({
    required int academicYearId,
    int? departmentId,
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
      final result = await CyclesCoursesService.deleteCourse(
        courseId: courseId,
      );
      emit(DeleteCourseSuccess(message: result));
    } catch (e) {
      emit(
        DeleteCourseFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }

  Future<void> updateCourse({
    required int courseId,
    String? nameAr,
    String? nameEn,
    required String code,
    int? departmentId,
    required int levelId,
    required int termId,
    required int yearId,
  }) async {
    if (!await checkInternet()) {
      emit(UpdateCourseFailure(error: "checkInternet".tr()));
      return;
    }
    emit(UpdateCourseLoading());
    try {
      final result = await CyclesCoursesService.updateCourse(
        courseId: courseId,
        nameAr: nameAr,
        nameEn: nameEn,
        code: code,
        departmentId: departmentId,
        levelId: levelId,
        termId: termId,
        yearId: yearId,
      );
      emit(
        UpdateCourseSuccess(
          message: result.data ?? 'Course updated successfully',
        ),
      );
    } catch (e) {
      emit(
        UpdateCourseFailure(
          error: e.toString().replaceFirst("Exception: ", "").trim(),
        ),
      );
    }
  }
}
