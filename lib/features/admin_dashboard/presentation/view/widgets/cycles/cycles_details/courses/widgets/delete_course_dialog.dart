import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

void showDeleteCourseAssignDialog({
  required BuildContext context,
  required CourseItemModel course,
}) {
  final cubit = context.read<AssignCubit>();

  showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: cubit,
      child: BlocListener<AssignCubit, AssignState>(
        listener: (ctx, state) {
          if (state is AssignFailure) {
            showSnackBar(ctx, state.error, AppColors.red);
          }
          if (state is DeleteAssignSuccess) {
            Navigator.of(dialogContext).pop();
            showSnackBar(context, state.message, AppColors.green);
            refreshCourses(context);
          }
        },
        child: DeleteCourseDialog(course: course, cubit: cubit),
      ),
    ),
  );
}

void refreshCourses(BuildContext context) {
  final year = AcademicYearCubit.get(context).selectedAcademicYear;
  final department = DepartmentCubit.get(context).selectedDepartment;
  final level = LevelCubit.get(context).selectedLevel;
  final term = TermCubit.get(context).selectedTerm;

  if (year != null && level != null && term != null) {
    CoursesCubit.get(context).getCourses(
      academicYearId: year.id,
      departmentId: department?.id,
      levelId: level.id,
      termId: term.id,
    );
  }
}

class DeleteCourseDialog extends StatelessWidget {
  final CourseItemModel course;
  final AssignCubit cubit;

  const DeleteCourseDialog({
    super.key,
    required this.course,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      actionsPadding: EdgeInsets.all(16.h),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: CustomText(
        title: 'removeAssignment'.tr(),
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.red,
        ),
      ),
      content: CustomText(
        title: 'removeAssignmentMessage'.tr(args: [course.name]),
        textStyle: Theme.of(
          context,
        ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
      ),
      actions: [
        BlocBuilder<AssignCubit, AssignState>(
          builder: (context, state) {
            if (state is DeleteAssignLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return DeleteAndCancelButtons(
              onPressed: () =>
                  cubit.removeAssignCourse(courseId: course.courseId),
            );
          },
        ),
      ],
    );
  }
}

void showDeleteCourseEntirelyDialog({
  required BuildContext context,
  required CourseItemModel course,
}) {
  final cubit = CoursesCubit.get(context);

  showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: cubit,
      child: BlocListener<CoursesCubit, CoursesState>(
        listener: (ctx, state) {
          if (state is DeleteCourseFailure) {
            showSnackBar(ctx, state.error, AppColors.red);
          }
          if (state is DeleteCourseSuccess) {
            Navigator.of(dialogContext).pop();
            showSnackBar(context, state.message, AppColors.green);
            refreshCourses(context);
          }
        },
        child: DeleteCourseEntirelyDialog(course: course, cubit: cubit),
      ),
    ),
  );
}

class DeleteCourseEntirelyDialog extends StatelessWidget {
  final CourseItemModel course;
  final CoursesCubit cubit;

  const DeleteCourseEntirelyDialog({
    super.key,
    required this.course,
    required this.cubit,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      actionsPadding: EdgeInsets.all(16.h),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: CustomText(
        title: 'deleteCourse'.tr(),
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.red,
        ),
      ),
      content: CustomText(
        title: 'deleteCourseMessage'.tr(args: [course.name]),
        textStyle: Theme.of(
          context,
        ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
      ),
      actions: [
        BlocBuilder<CoursesCubit, CoursesState>(
          builder: (context, state) {
            if (state is DeleteCourseLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return DeleteAndCancelButtons(
              onPressed: () =>
                  cubit.deleteCourseEntirely(courseId: course.courseId),
            );
          },
        ),
      ],
    );
  }
}
