import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'create_course_dialog_widgets.dart'
    hide buildFormField, buildLabel, buildAcademicYearInfo;
import 'edit_course_dialog_widgets.dart';

void showEditCourseDialog({
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
          debugPrint("EditCourseDialog BlocListener received state: $state");
          if (state is UpdateCourseSuccess) {
            try {
              Navigator.of(dialogContext).pop();
            } catch (e) {
              debugPrint("Error popping dialog: $e");
            }
            try {
              showSnackBar(context, state.message, AppColors.green);
            } catch (e) {
              debugPrint("Error showing success snackbar: $e");
            }
            try {
              refreshCourses(context);
            } catch (e) {
              debugPrint("Error refreshing courses: $e");
            }
          } else if (state is UpdateCourseFailure) {
            try {
              showSnackBar(ctx, state.error, AppColors.red);
            } catch (e) {
              debugPrint("Error showing failure snackbar: $e");
            }
          }
        },
        child: EditCourseDialog(course: course),
      ),
    ),
  );
}

class EditCourseDialog extends StatefulWidget {
  final CourseItemModel course;
  const EditCourseDialog({super.key, required this.course});

  @override
  State<EditCourseDialog> createState() => _EditCourseDialogState();
}

class _EditCourseDialogState extends State<EditCourseDialog> {
  int currentStage = 1;

  int? selectedDeptId;
  int? selectedLevelId;
  int? selectedTermId;

  final TextEditingController codeController = TextEditingController();
  final TextEditingController arabicNameController = TextEditingController();
  final TextEditingController englishNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    codeController.text = widget.course.code;

    final name = widget.course.name;
    final isAr = RegExp(r'[\u0600-\u06FF]').hasMatch(name);
    if (isAr) {
      arabicNameController.text = name;
      englishNameController.text = '';
    } else {
      arabicNameController.text = '';
      englishNameController.text = name;
    }

    selectedDeptId = widget.course.department.id != 0
        ? widget.course.department.id
        : null;
    selectedLevelId = widget.course.level.id;
    selectedTermId = widget.course.semester.id;
  }

  @override
  void dispose() {
    codeController.dispose();
    arabicNameController.dispose();
    englishNameController.dispose();
    super.dispose();
  }

  void handleUpdateCourse(BuildContext context) {
    if (selectedLevelId == null || selectedTermId == null) {
      showSnackBar(context, 'Please select Level and Term', AppColors.red);
      return;
    }

    final code = codeController.text.trim();
    if (code.isEmpty) {
      showSnackBar(context, 'Please fill Code field', AppColors.red);
      return;
    }
    if (code.length < 4 || code.length > 6) {
      showSnackBar(context, 'codeLengthError'.tr(), AppColors.red);
      return;
    }

    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id ?? 0;
    final nameAr = arabicNameController.text.trim().isEmpty
        ? widget.course.name
        : arabicNameController.text.trim();
    final nameEn = englishNameController.text.trim().isEmpty
        ? widget.course.name
        : englishNameController.text.trim();

    CoursesCubit.get(context).updateCourse(
      courseId: widget.course.courseId,
      nameAr: nameAr,
      nameEn: nameEn,
      code: code,
      departmentId: selectedDeptId == -1 ? null : selectedDeptId,
      levelId: selectedLevelId!,
      termId: selectedTermId!,
      yearId: yearId,
    );
  }

  @override
  Widget build(BuildContext context) {
    final year =
        AcademicYearCubit.get(
          context,
        ).selectedAcademicYear?.yearNumber.toString() ??
        '2025';

    return BlocListener<CoursesCubit, CoursesState>(
      listenWhen: (prev, current) => current is UpdateCourseSuccess,
      listener: (context, state) {
        if (state is UpdateCourseSuccess) {
          final deptCubit = DepartmentCubit.get(context);
          final levelCubit = LevelCubit.get(context);
          final termCubit = TermCubit.get(context);

          try {
            final newLevel = levelCubit.levels.firstWhere(
              (l) => l.id == selectedLevelId,
              orElse: () => levelCubit.selectedLevel ?? levelCubit.levels.first,
            );
            levelCubit.selectLevel(level: newLevel);
          } catch (e) {
            debugPrint("Error updating LevelCubit selection: $e");
          }

          try {
            final newTerm = termCubit.terms.firstWhere(
              (t) => t.id == selectedTermId,
              orElse: () => termCubit.selectedTerm ?? termCubit.terms.first,
            );
            termCubit.selectTerm(term: newTerm);
          } catch (e) {
            debugPrint("Error updating TermCubit selection: $e");
          }

          try {
            if (selectedDeptId != null && selectedDeptId != -1) {
              final newDept = deptCubit.departments.firstWhere(
                (d) => d.id == selectedDeptId,
                orElse: () =>
                    deptCubit.selectedDepartment ?? deptCubit.departments.first,
              );
              deptCubit.selectDepartment(department: newDept);
            } else {
              deptCubit.selectDepartment(department: null);
            }
          } catch (e) {
            debugPrint("Error updating DepartmentCubit selection: $e");
          }
        }
      },
      child: CustomDialog(
        title: 'editCourse'.tr(),
        maxWidth: 700.w,
        content: SingleChildScrollView(
          child: currentStage == 1
              ? buildStage1(
                  codeController: codeController,
                  arabicNameController: arabicNameController,
                  englishNameController: englishNameController,
                )
              : buildStage2(
                  year: year,
                  selectedDeptId: selectedDeptId,
                  selectedLevelId: selectedLevelId,
                  selectedTermId: selectedTermId,
                  onDeptChanged: (id) => setState(() {
                    selectedDeptId = id;
                  }),
                  onLevelChanged: (id) => setState(() {
                    selectedLevelId = id;
                  }),
                  onTermChanged: (id) => setState(() {
                    selectedTermId = id;
                  }),
                ),
        ),
        actions: currentStage == 1
            ? [
                buildActionButton(
                  title: 'transfer'.tr(),
                  onPressed: () => setState(() => currentStage = 2),
                  backgroundColor: AppColors.grey.withOpacity(0.1),
                  textColor: AppColors.mainBlack,
                ),
                BlocBuilder<CoursesCubit, CoursesState>(
                  builder: (context, state) {
                    if (state is UpdateCourseLoading) {
                      return SizedBox(
                        width: 100.w,
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      );
                    }
                    return buildActionButton(
                      title: 'confirm'.tr(),
                      onPressed: () => handleUpdateCourse(context),
                      backgroundColor: AppColors.blue,
                      textColor: AppColors.white,
                      isBold: true,
                    );
                  },
                ),
              ]
            : [
                buildActionButton(
                  title: 'back'.tr(),
                  onPressed: () => setState(() => currentStage = 1),
                  backgroundColor: AppColors.grey.withOpacity(0.1),
                  textColor: AppColors.mainBlack,
                ),
                BlocBuilder<CoursesCubit, CoursesState>(
                  builder: (context, state) {
                    if (state is UpdateCourseLoading) {
                      return SizedBox(
                        width: 120.w,
                        child: const Center(
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: AppColors.blue,
                            ),
                          ),
                        ),
                      );
                    }
                    return buildActionButton(
                      title: 'editCourse'.tr(),
                      onPressed: () => handleUpdateCourse(context),
                      backgroundColor: AppColors.blue,
                      textColor: AppColors.white,
                      isBold: true,
                    );
                  },
                ),
              ],
      ),
    );
  }
}
