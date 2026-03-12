import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesList extends StatelessWidget {
  const CoursesList({super.key});

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
              CourseCubit.get(context).fetchCourses(
                yearId: AcademicYearCubit.get(context).selectedAcademicYear!.id,
                levelId: LevelCubit.get(context).selectedLevel!.id,
                semesterId: SemesterCubit.get(context).selectedSemester!.id,
                departmentId: DepartmentCubit.get(
                  context,
                ).selectedDepartment!.id,
              );
            },
          );
        }
        if (state is CourseSuccess) {
          final List<String> courseName = state.courses
              .map((e) => e.name)
              .toList();
          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.8,
            ),
            itemBuilder: (context, index) {
              return CourseItemWidget(title: courseName[index], state: state);
            },
            itemCount: state.courses.length,
          );
        }
        return const SizedBox();
      },
    );
  }
}
