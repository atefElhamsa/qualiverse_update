import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class AssignmentsTopWidget extends StatefulWidget {
  const AssignmentsTopWidget({super.key});

  @override
  State<AssignmentsTopWidget> createState() => _AssignmentsTopWidgetState();
}

class _AssignmentsTopWidgetState extends State<AssignmentsTopWidget> {
  UserManagementModel? _selectedDoctor;

  void _triggerFetch() {
    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    if (yearId != null) {
      context.read<AssignmentsCubit>().fetchAssignments(
        academicYearId: yearId,
        doctorId: _selectedDoctor?.id,
        status: context.read<AssignmentStatusCubit>().selectedStatus?.value,
      );
    }
  }

  String _translateStatus(String statusName) {
    return statusName.toLowerCase().tr();
  }

  @override
  Widget build(BuildContext context) {
    final allDocsText = 'all_doctors'.tr();
    final allStatusesText = 'all_statuses'.tr();

    return BlocListener<AcademicYearCubit, AcademicYearState>(
      listener: (context, state) => _triggerFetch(),
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.mainBlack.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            // Doctor Dropdown
            Expanded(
              child: BlocBuilder<UsersCubit, UsersState>(
                builder: (context, state) {
                  final doctors = state is UsersSuccess
                      ? state.users
                            .where(
                              (u) => u.role == 'doctor' || u.role == 'admin',
                            )
                            .toList()
                      : <UserManagementModel>[];

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('doctor'.tr(), Icons.person_outline),
                      SizedBox(height: 10.h),
                      _buildDropdownContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<UserManagementModel?>(
                            value: _selectedDoctor,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.greyLight,
                              size: 20.sp,
                            ),
                            hint: Text(
                              allDocsText,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.greyLight,
                              ),
                            ),
                            items: [
                              DropdownMenuItem<UserManagementModel?>(
                                value: null,
                                child: Text(
                                  allDocsText,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...doctors.map(
                                (d) => DropdownMenuItem<UserManagementModel?>(
                                  value: d,
                                  child: Text(
                                    '${d.firstName} ${d.lastName}',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (val) {
                              setState(() => _selectedDoctor = val);
                              _triggerFetch();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            SizedBox(width: 24.w),
            // Status Dropdown
            Expanded(
              child: BlocBuilder<AssignmentStatusCubit, AssignmentStatusState>(
                builder: (context, state) {
                  final statuses = context
                      .read<AssignmentStatusCubit>()
                      .statuses;
                  final selectedStatus = context
                      .read<AssignmentStatusCubit>()
                      .selectedStatus;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildLabel('status'.tr(), Icons.assignment_outlined),
                      SizedBox(height: 10.h),
                      _buildDropdownContainer(
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<AssignmentStateModel?>(
                            value: selectedStatus,
                            isExpanded: true,
                            icon: Icon(
                              Icons.keyboard_arrow_down_rounded,
                              color: AppColors.greyLight,
                              size: 20.sp,
                            ),
                            hint: Text(
                              allStatusesText,
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: AppColors.greyLight,
                              ),
                            ),
                            items: [
                              DropdownMenuItem<AssignmentStateModel?>(
                                value: null,
                                child: Text(
                                  allStatusesText,
                                  style: TextStyle(
                                    fontSize: 15.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              ...statuses.map(
                                (s) => DropdownMenuItem<AssignmentStateModel?>(
                                  value: s,
                                  child: Text(
                                    _translateStatus(s.name),
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                            onChanged: (val) {
                              context
                                  .read<AssignmentStatusCubit>()
                                  .selectStatus(val);
                              _triggerFetch();
                            },
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, size: 15.sp, color: AppColors.blue),
        SizedBox(width: 8.w),
        CustomText(
          title: title,
          textStyle: TextStyle(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            color: AppColors.mainBlack,
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownContainer({required Widget child}) {
    return Container(
      height: 48.h,
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        border: Border.all(color: AppColors.grey.withOpacity(0.5)),
      ),
      child: child,
    );
  }
}
