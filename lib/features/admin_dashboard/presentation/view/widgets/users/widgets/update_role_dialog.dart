import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class UpdateRoleDialog extends StatefulWidget {
  final UserManagementModel user;
  const UpdateRoleDialog({super.key, required this.user});

  @override
  State<UpdateRoleDialog> createState() => _UpdateRoleDialogState();
}

class _UpdateRoleDialogState extends State<UpdateRoleDialog> {
  RoleModel? selectedRole;

  @override
  void initState() {
    super.initState();
    // Pre-select the user's current role if possible
    final rolesState = context.read<RolesCubit>().state;
    if (rolesState is RolesSuccess) {
      try {
        selectedRole = rolesState.roles.firstWhere(
          (r) => widget.user.roles.contains(r.name),
        );
      } catch (_) {
        selectedRole = null;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserRoleCubit, UpdateUserRoleState>(
      listener: (context, state) {
        if (state is UpdateUserRoleSuccess) {
          showSnackBar(context, state.message, AppColors.green);
          context.read<UsersCubit>().fetchUsers();

          final meState = context.read<MeCubit>().state;
          if (meState is MeSuccess && meState.meModel.id == widget.user.id) {
            context.read<MeCubit>().getMyInfo();
          }

          Navigator.pop(context);
        }
        if (state is UpdateUserRoleFailure) {
          showSnackBar(context, state.errorMessage, AppColors.red);
        }
      },
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: AppColors.white,
        child: Container(
          width: 400.w,
          padding: EdgeInsets.all(24.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                title: 'changeRole'.tr(),
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontSize: 22.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainBlack,
                ),
              ),
              SizedBox(height: 8.h),
              CustomText(
                title: '${'user'.tr()}: ${widget.user.fullName}',
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 24.h),
              BlocBuilder<RolesCubit, RolesState>(
                builder: (context, state) {
                  if (state is RolesLoading) {
                    return const Center(
                      child: Padding(
                        padding: EdgeInsets.all(20.0),
                        child: CustomLoading(),
                      ),
                    );
                  }
                  if (state is RolesFailure) {
                    return Center(
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }
                  if (state is RolesSuccess) {
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<RoleModel>(
                          value: selectedRole,
                          isExpanded: true,
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: AppColors.tooltipBehavior,
                          ),
                          hint: Text(
                            'selectType'.tr(),
                            style: TextStyle(fontSize: 15.sp),
                          ),
                          items: state.roles.map((role) {
                            return DropdownMenuItem(
                              value: role,
                              child: Text(
                                ("${role.name.toLowerCase()}Role").tr(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  color: AppColors.mainBlack,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (val) =>
                              setState(() => selectedRole = val),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                    ),
                    child: Text(
                      'cancel'.tr(),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 15.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  BlocBuilder<UpdateUserRoleCubit, UpdateUserRoleState>(
                    builder: (context, state) {
                      final bool isLoading = state is UpdateUserRoleLoading;
                      return ElevatedButton(
                        onPressed: (selectedRole == null || isLoading)
                            ? null
                            : () {
                                context.read<UpdateUserRoleCubit>().updateRole(
                                  userId: widget.user.id,
                                  roleId: selectedRole!.id,
                                );
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.tooltipBehavior,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: 32.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: isLoading
                            ? SizedBox(
                                width: 20.w,
                                height: 20.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : Text(
                                'updateRole'.tr(),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.bold,
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
