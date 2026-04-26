import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_dialog.dart';

import '../../../../../../../../../routing/all_routes_imports.dart';

void showAssignCourseDialog(BuildContext context, CourseModel course) {
  showDialog(
    context: context,
    builder: (_) => AssignCourseDialog(course: course),
  );
}

class AssignCourseDialog extends StatefulWidget {
  final CourseModel course;

  const AssignCourseDialog({super.key, required this.course});

  @override
  State<AssignCourseDialog> createState() => _AssignCourseDialogState();
}

class _AssignCourseDialogState extends State<AssignCourseDialog> {
  UserManagementModel? _selectedDoctor;
  DateTime? _selectedDeadline;
  bool _dropdownOpen = false;

  void _toggleDropdown() => setState(() => _dropdownOpen = !_dropdownOpen);

  void _onDoctorSelected(UserManagementModel doctor) => setState(() {
    _selectedDoctor = doctor;
    _dropdownOpen = false;
  });

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(
            primary: AppColors.blue,
            onPrimary: AppColors.white,
            onSurface: AppColors.mainBlack,
          ),
          datePickerTheme: DatePickerThemeData(
            headerHeadlineStyle: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
            headerHelpStyle: TextStyle(
              fontSize: 14.sp,
              color: AppColors.white.withOpacity(0.8),
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: AppColors.blue,
              textStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => _selectedDeadline = picked);
  }

  void _onSave(BuildContext context) {
    if (_selectedDoctor == null) {
      showSnackBar(context, 'Please Select Doctor', AppColors.red);
      return;
    }
    if (_selectedDeadline == null) {
      showSnackBar(context, 'Please Select Deadline', AppColors.red);
      return;
    }
    AssignCubit.get(context).assign(
      indicatorId: widget.course.id,
      doctorId: _selectedDoctor!.id,
      deadline: _selectedDeadline!.toIso8601String(),
    );
  }

  void _onAssignSuccess(BuildContext context, AssignSuccess state) {
    showSnackBar(context, state.message, AppColors.green);
    Navigator.pop(context);
    _refreshCourses(context);
  }

  void _refreshCourses(BuildContext context) {
    final year = AcademicYearCubit.get(context).selectedAcademicYear;
    final department = DepartmentCubit.get(context).selectedDepartment;
    final level = LevelCubit.get(context).selectedLevel;
    final semester = SemesterCubit.get(context).selectedSemester;

    if (year != null &&
        department != null &&
        level != null &&
        semester != null) {
      CourseCubit.get(context).fetchCourses(
        yearId: year.id,
        departmentId: department.id,
        levelId: level.id,
        semesterId: semester.id,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AssignCubit, AssignState>(
      listener: (context, state) {
        if (state is AssignSuccess) _onAssignSuccess(context, state);
        if (state is AssignFailure)
          showSnackBar(context, state.error, AppColors.red);
      },
      builder: (context, assignState) {
        return CustomDialog(
          title: 'Assign Course',
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
                selectedDoctor: _selectedDoctor,
                dropdownOpen: _dropdownOpen,
                onToggle: _toggleDropdown,
                onSelect: _onDoctorSelected,
              ),
              SizedBox(height: 16.h),
              DeadlineSection(
                selectedDeadline: _selectedDeadline,
                onTap: _pickDate,
              ),
            ],
          ),
          actions: [
            _buildButton(
              title: 'Cancel',
              onPressed: () => Navigator.pop(context),
              backgroundColor: AppColors.grey.withOpacity(0.1),
              textColor: AppColors.mainBlack,
            ),
            _buildButton(
              title: assignState is AssignLoading ? 'Saving...' : 'Save',
              onPressed: assignState is AssignLoading
                  ? () {}
                  : () => _onSave(context),
              backgroundColor: AppColors.blue,
              textColor: AppColors.white,
              isBold: true,
            ),
          ],
        );
      },
    );
  }

  Widget _buildButton({
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
