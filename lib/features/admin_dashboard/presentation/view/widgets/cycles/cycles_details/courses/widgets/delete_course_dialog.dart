import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';

// ─── Show Dialog Helper ───────────────────────────────────────────────────────

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
            showSnackBar(ctx, state.message, AppColors.green);
            Navigator.of(dialogContext).pop();
            _refreshCourses(context);
          }
        },
        child: _DeleteCourseDialog(course: course, cubit: cubit),
      ),
    ),
  );
}

void _refreshCourses(BuildContext context) {
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

// ─── Dialog Widget ────────────────────────────────────────────────────────────

class _DeleteCourseDialog extends StatelessWidget {
  final CourseItemModel course;
  final AssignCubit cubit;

  const _DeleteCourseDialog({required this.course, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.white,
      actionsPadding: EdgeInsets.all(16.h),
      actionsAlignment: MainAxisAlignment.center,
      alignment: Alignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
      title: CustomText(
        title: 'Remove Assignment',
        textAlign: TextAlign.center,
        textStyle: GoogleFonts.inter(
          fontSize: 22.sp,
          fontWeight: FontWeight.w700,
          color: AppColors.red,
        ),
      ),
      content: CustomText(
        title:
            'Are you sure you want to remove the assignment from "${course.name}"?',
        textStyle: Theme.of(
          context,
        ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
      ),
      actions: [
        DeleteAndCancelButtons(
          onPressed: () => cubit.removeAssignCourse(courseId: course.courseId),
        ),
      ],
    );
  }
}
