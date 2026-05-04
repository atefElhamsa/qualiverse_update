import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';

class CoursesTableBuilderWidget extends StatefulWidget {
  final String searchQuery;

  const CoursesTableBuilderWidget({super.key, this.searchQuery = ''});

  @override
  State<CoursesTableBuilderWidget> createState() => _CoursesTableBuilderWidgetState();
}

class _CoursesTableBuilderWidgetState extends State<CoursesTableBuilderWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkAndFetch();
    });
  }

  void _checkAndFetch() {
    if (!mounted) return;
    final year = AcademicYearCubit.get(context).selectedAcademicYear;
    final department = DepartmentCubit.get(context).selectedDepartment;
    final level = LevelCubit.get(context).selectedLevel;
    final term = TermCubit.get(context).selectedTerm;

    if (year != null && level != null && term != null) {
      CoursesCubit.get(context).getCourses(
        academicYearId: year.id,
        departmentId: level.levelNumber <= 2 ? null : department?.id,
        levelId: level.id,
        termId: term.id,
      );
    }
  }

  List<CourseItemModel> _applySearch(List<CourseItemModel> courses) {
    if (widget.searchQuery.isEmpty) return courses;
    final q = widget.searchQuery.toLowerCase();
    return courses.where((c) {
      return c.name.toLowerCase().contains(q) ||
          c.code.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AcademicYearCubit, AcademicYearState>(
          listener: (ctx, _) => _checkAndFetch(),
        ),
        BlocListener<DepartmentCubit, DepartmentState>(
          listener: (ctx, _) => _checkAndFetch(),
        ),
        BlocListener<LevelCubit, LevelState>(
          listener: (ctx, _) => _checkAndFetch(),
        ),
        BlocListener<TermCubit, TermState>(
          listener: (ctx, _) => _checkAndFetch(),
        ),
      ],
      child: BlocBuilder<CoursesCubit, CoursesState>(
        buildWhen: (previous, current) {
          return current is CoursesLoading ||
              current is CoursesSuccess ||
              current is CoursesFailure ||
              current is CoursesInitial;
        },
        builder: (context, state) {
          if (state is CoursesInitial) {
            _checkAndFetch();
          }
          if (state is CoursesLoading) return const LoadingView();
          if (state is CoursesFailure) return ErrorView(message: state.error);
          if (state is CoursesSuccess) {
            final filtered = _applySearch(state.courses);
            if (filtered.isEmpty) {
              return EmptyView(message: 'noCoursesFound'.tr());
            }
            return CoursesTable(courses: filtered);
          }
          return EmptyView(
            message: 'selectCourseFilters'.tr(),
          );
        },
      ),
    );
  }
}

class LoadingView extends StatelessWidget {
  const LoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(32),
      child: Center(child: CustomLoading()),
    );
  }
}

class ErrorView extends StatelessWidget {
  final String message;

  const ErrorView({super.key, required this.message});

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

class EmptyView extends StatelessWidget {
  final String message;

  const EmptyView({required this.message});

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
