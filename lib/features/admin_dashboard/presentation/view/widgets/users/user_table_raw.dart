import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'widgets/update_role_dialog.dart';

class UserTableRow extends StatelessWidget {
  final UserManagementModel user;
  final int index;
  final int total;

  const UserTableRow({
    super.key,
    required this.user,
    required this.index,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: CustomText(
                  title: user.fullName,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 15.sp),
                ),
              ),
              Expanded(
                child: CustomText(
                  title: user.email,
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 15.sp),
                ),
              ),
              Expanded(
                child: CustomText(
                  title: ("${user.role.toLowerCase()}Role").tr(),
                  textAlign: TextAlign.center,
                  textStyle: Theme.of(
                    context,
                  ).textTheme.titleMedium!.copyWith(fontSize: 15.sp),
                ),
              ),
              Expanded(
                child: Center(
                  child: GestureDetector(
                    onTap: user.role.toLowerCase() == 'admin'
                        ? null
                        : () {
                            final cubit = UsersCubit.get(context);
                            user.isActive
                                ? cubit.deactivateUser(id: user.id)
                                : cubit.activateUser(id: user.id);
                          },
                    child: UserStatusBadge(
                      status: user.status,
                      isDisabled: user.role.toLowerCase() == 'admin',
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Tooltip(
                      message: user.role.toLowerCase() == 'admin'
                          ? ''
                          : 'edit'.tr(),
                      child: MouseRegion(
                        cursor: user.role.toLowerCase() == 'admin'
                            ? SystemMouseCursors.basic
                            : SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: user.role.toLowerCase() == 'admin'
                              ? null
                              : () => showUpdateRoleDialog(
                                  context: context,
                                  user: user,
                                ),
                          child: Icon(
                            Icons.edit_outlined,
                            color: user.role.toLowerCase() == 'admin'
                                ? Colors.grey
                                : AppColors.blue,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Tooltip(
                      message: user.role.toLowerCase() == 'admin'
                          ? ''
                          : 'deleteUser'.tr(),
                      child: MouseRegion(
                        cursor: user.role.toLowerCase() == 'admin'
                            ? SystemMouseCursors.basic
                            : SystemMouseCursors.click,
                        child: GestureDetector(
                          onTap: user.role.toLowerCase() == 'admin'
                              ? null
                              : () => showDeleteUserDialog(
                                  context: context,
                                  user: user,
                                ),
                          child: Icon(
                            Icons.delete_outline,
                            color: user.role.toLowerCase() == 'admin'
                                ? Colors.grey
                                : Colors.red,
                            size: 22.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        if (index < total - 1) const Divider(height: 1, color: AppColors.white),
      ],
    );
  }
}

void showUpdateRoleDialog({
  required BuildContext context,
  required UserManagementModel user,
}) {
  showDialog(
    context: context,
    builder: (dialogContext) => UpdateRoleDialog(user: user),
  );
}

void showDeleteUserDialog({
  required BuildContext context,
  required UserManagementModel user,
}) {
  final cubit = context.read<UsersCubit>();
  showDialog(
    context: context,
    builder: (dialogContext) => BlocProvider.value(
      value: cubit,
      child: BlocListener<UsersCubit, UsersState>(
        listener: (listenerContext, state) {
          if (state is DeleteUserFailure) {
            showSnackBar(listenerContext, state.error, AppColors.red);
          }
          if (state is DeleteUserSuccess) {
            showSnackBar(listenerContext, state.message, AppColors.green);
            Navigator.of(dialogContext).pop();
            cubit.fetchUsers();
          }
        },
        child: AlertDialog(
          backgroundColor: AppColors.white,
          actionsPadding: EdgeInsets.all(16.h),
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: CustomText(
            title: 'deleteUser'.tr(),
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.red,
            ),
          ),
          content: CustomText(
            title: "deleteUserMessage".tr(),
            textStyle: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: AppColors.mainBlack),
          ),
          actions: [
            DeleteAndCancelButtons(
              onPressed: () {
                cubit.deleteUser(id: user.id);
              },
            ),
          ],
        ),
      ),
    ),
  );
}
