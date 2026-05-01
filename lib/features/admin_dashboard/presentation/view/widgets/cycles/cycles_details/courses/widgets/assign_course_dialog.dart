import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

void showAssignCourseDialog(BuildContext context, CourseItemModel course) {
  showDialog(
    context: context,
    builder: (_) => AssignCourseDialog(course: course),
  );
}

class AssignCourseDialog extends StatefulWidget {
  final CourseItemModel course;

  const AssignCourseDialog({super.key, required this.course});

  @override
  State<AssignCourseDialog> createState() => _AssignCourseDialogState();
}

class _AssignCourseDialogState extends State<AssignCourseDialog> {
  UserManagementModel? selectedDoctor;
  bool dropdownOpen = false;

  void toggleDropdown() => setState(() => dropdownOpen = !dropdownOpen);

  void onDoctorSelected(UserManagementModel doctor) => setState(() {
    selectedDoctor = doctor;
    dropdownOpen = false;
  });

  void onSave(BuildContext context) {
    if (selectedDoctor == null) {
      showSnackBar(context, 'pleaseSelectDoctor'.tr(), AppColors.red);
      return;
    }
    AssignCubit.get(context).assignCourse(
      courseId: widget.course.courseId,
      doctorId: selectedDoctor!.id,
    );
  }

  void onAssignSuccess(BuildContext context, AssignSuccess state) {
    showSnackBar(context, state.message, AppColors.green);
    Navigator.pop(context);
    refreshCourses(context);
  }

  void refreshCourses(BuildContext context) {
    final year = AcademicYearCubit.get(context).selectedAcademicYear;
    final department = DepartmentCubit.get(context).selectedDepartment;
    final level = LevelCubit.get(context).selectedLevel;
    final term = TermCubit.get(context).selectedTerm;

    if (year != null &&
        department != null &&
        level != null &&
        term != null) {
      CoursesCubit.get(context).getCourses(
        academicYearId: year.id,
        departmentId: department.id,
        levelId: level.id,
        termId: term.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignCubit, AssignState>(
      listener: (context, state) {
        if (state is AssignSuccess) onAssignSuccess(context, state);
        if (state is AssignFailure) {
          showSnackBar(context, state.error, AppColors.red);
        }
      },
      builder: (context, assignState) {
        return CustomDialog(
          title: 'assignCourse'.tr(),
          maxWidth: 480.w,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: widget.course.name,
                textStyle: TextStyle(
                  fontSize: 13.sp,
                  color: AppColors.greyLight,
                ),
              ),
              SizedBox(height: 20.h),
              DoctorSection(
                selectedDoctor: selectedDoctor,
                dropdownOpen: dropdownOpen,
                onToggle: toggleDropdown,
                onSelect: onDoctorSelected,
              ),
            ],
          ),
          actions: [
            buildButton(
              title: 'cancel'.tr(),
              onPressed: () => Navigator.pop(context),
              backgroundColor: AppColors.grey.withOpacity(0.1),
              textColor: AppColors.mainBlack,
            ),
            buildButton(
              title: assignState is AssignLoading ? 'saving'.tr() : 'save'.tr(),
              onPressed: assignState is AssignLoading
                  ? () {}
                  : () => onSave(context),
              backgroundColor: AppColors.blue,
              textColor: AppColors.white,
              isBold: true,
            ),
          ],
        );
      },
    );
  }

  Widget buildButton({
    required String title,
    required VoidCallback onPressed,
    required Color backgroundColor,
    required Color textColor,
    bool isBold = false,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        backgroundColor: backgroundColor,
        elevation: backgroundColor == AppColors.blue ? 3 : 0,
        shadowColor: backgroundColor == AppColors.blue
            ? AppColors.blue.withOpacity(0.4)
            : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
      ),
      child: CustomText(
        title: title,
        textStyle: TextStyle(
          color: textColor,
          fontSize: 14.sp,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
