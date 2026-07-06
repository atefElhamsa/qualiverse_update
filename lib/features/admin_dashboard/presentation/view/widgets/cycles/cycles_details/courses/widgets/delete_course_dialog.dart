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

class DeleteCourseEntirelyDialog extends StatefulWidget {
  final CourseItemModel course;
  final CoursesCubit cubit;

  const DeleteCourseEntirelyDialog({
    super.key,
    required this.course,
    required this.cubit,
  });

  @override
  State<DeleteCourseEntirelyDialog> createState() =>
      _DeleteCourseEntirelyDialogState();
}

class _DeleteCourseEntirelyDialogState
    extends State<DeleteCourseEntirelyDialog> {
  final TextEditingController _deleteController = TextEditingController();
  bool _canDelete = false;

  @override
  void initState() {
    super.initState();
    _deleteController.addListener(() {
      setState(() {
        _canDelete = _deleteController.text.toLowerCase() == 'delete';
      });
    });
  }

  @override
  void dispose() {
    _deleteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 480),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomText(
                      title: 'deleteCourse'.tr(),
                      textStyle: Theme.of(context).textTheme.titleLarge!
                          .copyWith(
                            fontSize: 15.sp,
                            color: AppColors.red,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: const Icon(Icons.close, size: 20),
                    color: const Color(0xFF6B6B80),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              CustomText(
                title: 'deleteCourseMessage'.tr(args: [widget.course.name]),
                textStyle: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontSize: 14.sp,
                  color: AppColors.mainBlack,
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _deleteController,
                autofocus: true,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(color: AppColors.red),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: AppColors.red,
                      width: 2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 6),
              CustomText(
                title: 'typeDeleteToConfirm'.tr(),
                textStyle: const TextStyle(
                  fontSize: 12,
                  color: Color(0xFF9999AA),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF2C2C3E),
                      side: const BorderSide(color: Color(0xFFBBBBCC)),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: CustomText(
                      title: 'cancel'.tr(),
                      textStyle: Theme.of(context).textTheme.titleMedium!,
                    ),
                  ),
                  const SizedBox(width: 12),
                  BlocBuilder<CoursesCubit, CoursesState>(
                    builder: (context, state) {
                      if (state is DeleteCourseLoading) {
                        return const SizedBox(
                          height: 36,
                          width: 36,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        );
                      }
                      return FilledButton(
                        onPressed: _canDelete
                            ? () {
                                widget.cubit.deleteCourseEntirely(
                                    courseId: widget.course.courseId);
                              }
                            : null,
                        style: FilledButton.styleFrom(
                          backgroundColor: AppColors.red,
                          disabledBackgroundColor: AppColors.grey.withOpacity(0.3),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: CustomText(
                          title: 'delete'.tr(),
                          textStyle: Theme.of(context).textTheme.titleMedium!
                              .copyWith(
                                color: _canDelete
                                    ? AppColors.white
                                    : AppColors.grey,
                              ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
