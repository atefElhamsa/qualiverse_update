import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

void showAssignDialog(
  BuildContext context,
  CycleIndicatorModel cycleIndicator,
) {
  showDialog(
    context: context,
    builder: (dialogContext) =>
        AssignIndicatorDialog(cycleIndicator: cycleIndicator),
  );
}

class AssignIndicatorDialog extends StatefulWidget {
  const AssignIndicatorDialog({super.key, required this.cycleIndicator});

  final CycleIndicatorModel cycleIndicator;

  @override
  State<AssignIndicatorDialog> createState() => AssignIndicatorDialogState();
}

class AssignIndicatorDialogState extends State<AssignIndicatorDialog> {
  UserManagementModel? selectedDoctor;
  DateTime? selectedDeadline;
  bool dropdownOpen = false;

  @override
  void initState() {
    super.initState();
    selectedDeadline = widget.cycleIndicator.deadline;
  }

  void toggleDropdown() => setState(() => dropdownOpen = !dropdownOpen);

  void onDoctorSelected(UserManagementModel doctor) => setState(() {
    selectedDoctor = doctor;
    dropdownOpen = false;
  });

  Future<void> pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDeadline ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialEntryMode: DatePickerEntryMode.calendarOnly,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          datePickerTheme: DatePickerThemeData(
            headerHeadlineStyle: Theme.of(context).textTheme.titleMedium!,
            headerHelpStyle: Theme.of(
              context,
            ).textTheme.bodyMedium!.copyWith(color: AppColors.grey),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              textStyle: Theme.of(context).textTheme.bodyMedium!,
            ),
          ),
        ),
        child: child!,
      ),
    );
    if (picked != null) setState(() => selectedDeadline = picked);
  }

  void onSave(BuildContext context) {
    if (selectedDoctor == null) {
      showSnackBar(context, 'Please Select Doctor', AppColors.red);
      return;
    }
    if (selectedDeadline == null) {
      showSnackBar(context, 'Please Select Deadline', AppColors.red);
      return;
    }
    AssignCubit.get(context).assign(
      indicatorId: widget.cycleIndicator.indicatorId,
      doctorId: selectedDoctor!.id,
      deadline: selectedDeadline!.toIso8601String(),
    );
  }

  void onAssignSuccess(BuildContext context, AssignSuccess state) {
    showSnackBar(context, state.message, AppColors.green);
    Navigator.pop(context);
    CycleIndicatorCubit.get(context).fetchCycleIndicators(
      yearId: AcademicYearCubit.get(context).selectedAcademicYear!.id,
      departmentId: DepartmentCubit.get(context).selectedDepartment!.id,
      criterionId: ProgramAccreditationCubit.get(
        context,
      ).selectedProgramAccreditation!.id,
    );
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
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 480.w),
            child: Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DialogHeader(onClose: () => Navigator.pop(context)),
                  SizedBox(height: 20.h),
                  DoctorSection(
                    selectedDoctor: selectedDoctor,
                    dropdownOpen: dropdownOpen,
                    onToggle: toggleDropdown,
                    onSelect: onDoctorSelected,
                  ),
                  SizedBox(height: 16.h),
                  DeadlineSection(
                    selectedDeadline: selectedDeadline,
                    onTap: pickDate,
                  ),
                  SizedBox(height: 24.h),
                  DialogActions(
                    isLoading: assignState is AssignLoading,
                    onCancel: () => Navigator.pop(context),
                    onSave: () => onSave(context),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
