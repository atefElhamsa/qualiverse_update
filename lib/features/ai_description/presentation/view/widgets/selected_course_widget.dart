import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SelectedCourseWidget extends StatelessWidget {
  const SelectedCourseWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return const CustomLoading();
        }
        if (state is CourseError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              final year = AcademicYearCubit.get(context).selectedAcademicYear;
              final level = LevelCubit.get(context).selectedLevel;
              final semester = TermCubit.get(context).selectedTerm;
              final department = DepartmentCubit.get(
                context,
              ).selectedDepartment;

              if (year != null && level != null && semester != null) {
                CourseCubit.get(context).fetchCourses(
                  yearId: year.id,
                  levelId: level.id,
                  semesterId: semester.id,
                  departmentId: department?.id,
                );
              }
            },
          );
        }
        if (state is CourseSuccess || state is CourseInitial) {
          final courseCubit = CourseCubit.get(context);
          final List<CourseModel> courses = (state is CourseSuccess)
              ? state.courses
              : [];
          final List<String> courseNames = courses.map((e) => e.name).toList();
          final String? selectedCourseName = courseCubit.selectedCourse?.name;

          return CustomDropButtonAndTitle(
            dropButtonModel: DropButtonModel(
              selectedData: selectedCourseName,
              listOfData: courseNames,
              hintText: "selectCourse".tr(),
              hintSize: 20.sp,
              onChanged: (value) {
                if (value == null) return;
                final selectedModel = courses.firstWhere(
                  (d) => d.name == value,
                );
                courseCubit.selectCourse(course: selectedModel);
              },
            ),
            title: "course".tr(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
