import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';

// ─── Main Builder Widget ──────────────────────────────────────────────────────

class CoursesTableBuilderWidget extends StatelessWidget {
  final String searchQuery;

  const CoursesTableBuilderWidget({super.key, this.searchQuery = ''});

  // ── Fetch Logic ───────────────────────────────────────────────────────────

  void _checkAndFetch(BuildContext context) {
    final year = AcademicYearCubit.get(context).selectedAcademicYear;
    final department = DepartmentCubit.get(context).selectedDepartment;
    final level = LevelCubit.get(context).selectedLevel;
    final semester = SemesterCubit.get(context).selectedSemester;

    if (year != null && department != null && level != null && semester != null) {
      CoursesCubit.get(context).getCourses(
        academicYearId: year.id,
        departmentId: department.id,
        levelId: level.id,
        semesterId: semester.id,
      );
    }
  }

  // ── Filtering ─────────────────────────────────────────────────────────────

  List<CourseItemModel> _applySearch(List<CourseItemModel> courses) {
    if (searchQuery.isEmpty) return courses;
    final q = searchQuery.toLowerCase();
    return courses.where((c) {
      return c.name.toLowerCase().contains(q) || c.code.toLowerCase().contains(q);
    }).toList();
  }

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AcademicYearCubit, AcademicYearState>(
          listener: (ctx, _) => _checkAndFetch(ctx),
        ),
        BlocListener<DepartmentCubit, DepartmentState>(
          listener: (ctx, _) => _checkAndFetch(ctx),
        ),
        BlocListener<LevelCubit, LevelState>(
          listener: (ctx, _) => _checkAndFetch(ctx),
        ),
        BlocListener<SemesterCubit, SemesterState>(
          listener: (ctx, _) => _checkAndFetch(ctx),
        ),
      ],
      child: BlocBuilder<CoursesCubit, CoursesState>(
        builder: (context, state) {
          if (state is CoursesLoading) return const _LoadingView();
          if (state is CoursesFailure) return _ErrorView(message: state.error);
          if (state is CoursesSuccess) {
            final filtered = _applySearch(state.courses);
            if (filtered.isEmpty) return const _EmptyView(message: 'No courses found');
            return CoursesTable(courses: filtered);
          }
          return const _EmptyView(
            message: 'Select department, level, and semester to view courses',
          );
        },
      ),
    );
  }
}

// ─── State Views ──────────────────────────────────────────────────────────────

class _LoadingView extends StatelessWidget {
  const _LoadingView();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: CustomLoading()),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;

  const _ErrorView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: CustomText(
          title: message,
          textStyle: TextStyle(fontSize: 15.sp, color: AppColors.red),
        ),
      ),
    );
  }
}

class _EmptyView extends StatelessWidget {
  final String message;

  const _EmptyView({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(32),
      child: Center(
        child: CustomText(
          title: message,
          textStyle: TextStyle(fontSize: 15.sp, color: AppColors.greyLight),
        ),
      ),
    );
  }
}
