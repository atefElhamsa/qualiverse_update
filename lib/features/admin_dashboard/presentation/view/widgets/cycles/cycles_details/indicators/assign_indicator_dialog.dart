import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';

void showAssignDialog(
  BuildContext context,
  CycleIndicatorModel cycleIndicator,
) {
  final cubit = AssignCubit.get(context);
  final indicatorCubit = CycleIndicatorCubit.get(context);
  final outerContext = context;

  showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: cubit,
      child: BlocListener<AssignCubit, AssignState>(
        listener: (_, state) {
          if (state is AssignSuccess) {
            Navigator.of(dialogContext).pop();
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (outerContext.mounted) {
                showSnackBar(outerContext, state.message, AppColors.green);
              }
              // ✅ Manual fetch after assign
              indicatorCubit.fetchCycleIndicators(
                yearId: AcademicYearCubit.get(outerContext).selectedAcademicYear!.id,
                departmentId: DepartmentCubit.get(outerContext).selectedDepartment?.id,
                criterionId: ProgramAccreditationCubit.get(outerContext).selectedProgramAccreditation!.id,
              );
            });
          }
          if (state is AssignFailure) {
            showSnackBar(dialogContext, state.error, AppColors.red);
          }
        },
        child: AssignIndicatorDialog(cycleIndicator: cycleIndicator),
      ),
    ),
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
    if (picked != null) setState(() => selectedDeadline = picked);
  }

  void onSave(BuildContext context) {
    if (selectedDoctor == null) {
      showSnackBar(context, 'pleaseSelectDoctor'.tr(), AppColors.red);
      return;
    }
    if (selectedDeadline == null) {
      showSnackBar(context, 'pleaseSelectDeadline'.tr(), AppColors.red);
      return;
    }
    AssignCubit.get(context).assignIndicator(
      indicatorId: widget.cycleIndicator.indicatorId,
      doctorId: selectedDoctor!.id,
      deadline: selectedDeadline!.toIso8601String(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AssignCubit, AssignState>(
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
