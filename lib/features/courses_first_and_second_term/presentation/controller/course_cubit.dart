import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../routing/all_routes_imports.dart';

class CourseCubit extends Cubit<CourseState> {
  CourseCubit() : super(CourseInitial());

  static CourseCubit get(BuildContext context) => BlocProvider.of(context);

  List<CourseModel> courses = [];
  CourseModel? selectedCourse;

  void selectCourse({required CourseModel course}) {
    selectedCourse = course;
    emit(CourseSuccess(courses: courses, selectedCourse: selectedCourse));
  }

  Future<void> fetchCourses({
    required int yearId,
    required int levelId,
    required int semesterId,
    required int departmentId,
  }) async {
    emit(CourseLoading());
    try {
      final data = await CourseService.getCourses(
        yearId: yearId,
        levelId: levelId,
        semesterId: semesterId,
        departmentId: departmentId,
      );
      courses = data;
      emit(CourseSuccess(courses: courses, selectedCourse: selectedCourse));
    } catch (e) {
      final msg = e.toString();
      if (msg.contains('No Internet')) {
        emit(CourseError(message: 'Check your internet connection'));
      } else if (msg.contains('Unauthorized')) {
        await LoginStorage.clear();
        reset();
        emit(CourseError(message: 'Session expired, please login again'));
      } else {
        emit(CourseError(message: 'Something went wrong'));
      }
    }
  }

  void reset() {
    courses = [];
    selectedCourse = null;
    emit(CourseInitial());
  }
}
