import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/evidence_overview/custom_filter_dropdown.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_state.dart';

import 'package:qualiverse/features/setting/presentation/controller/me/me_cubit.dart';
import 'package:qualiverse/features/setting/presentation/controller/me/me_state.dart';

class NotificationHeader extends StatelessWidget {
  final bool isDark;
  final bool? selectedFilter;
  final Function(bool?) onFilterChanged;

  const NotificationHeader({
    super.key,
    required this.isDark,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'accountNotification'.tr(),
                style: TextStyle(
                  fontSize: 28.sp,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppColors.white : AppColors.mainBlack,
                ),
              ),
              SizedBox(height: 4.h),
              Row(
                children: [
                  Text(
                    'notificationSubtitle'.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.greyLight,
                    ),
                  ),
                  const Spacer(),
                  BlocBuilder<NotificationsCubit, NotificationsState>(
                    buildWhen: (previous, current) =>
                        current is NotificationsSuccess ||
                        current is NotificationsLoading,
                    builder: (context, state) {
                      final cubit = context.read<NotificationsCubit>();
                      final notifications = cubit.allNotifications;
                      final hasUnread = notifications.any((n) => !n.isRead);
                      final isEmpty = notifications.isEmpty;
                      final isMarkAllEnabled = !isEmpty && hasUnread;
                      final isCleanupEnabled = !isEmpty;

                      return Row(
                        children: [
                          InkWell(
                            onTap: isMarkAllEnabled
                                ? () => cubit.markAllAsRead()
                                : null,
                            child: CustomText(
                              title: "mark_all_as_read".tr(),
                              textStyle: TextStyle(
                                fontSize: 13.sp,
                                fontWeight: FontWeight.w600,
                                color: isMarkAllEnabled
                                    ? AppColors.progressColor
                                    : AppColors.greyLight.withOpacity(0.5),
                              ),
                            ),
                          ),
                          BlocBuilder<MeCubit, MeState>(
                            builder: (context, meState) {
                              final isAdmin = meState is MeSuccess &&
                                  meState.meModel.role.toLowerCase() == 'admin';

                              if (!isAdmin) return const SizedBox();

                              return Row(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 8.w,
                                    ),
                                    child: Text(
                                      "|",
                                      style: TextStyle(
                                        color: AppColors.greyLight.withOpacity(
                                          0.3,
                                        ),
                                        fontSize: 13.sp,
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: isCleanupEnabled
                                        ? () => _showCleanupConfirmation(
                                          context,
                                          cubit,
                                        )
                                        : null,
                                    child: CustomText(
                                      title: "cleanup_notifications".tr(),
                                      textStyle: TextStyle(
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                        color: isCleanupEnabled
                                            ? AppColors.rejectedColorIndicator
                                            : AppColors.greyLight.withOpacity(
                                              0.5,
                                            ),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        SizedBox(width: 24.w),
        SizedBox(
          width: 180.w,
          child: CustomFilterDropdown<bool?>(
            hint: "all".tr(),
            value: selectedFilter,
            items: [
              DropdownMenuItem(
                value: null,
                child: CustomText(
                  title: "all".tr(),
                  textStyle: TextStyle(fontSize: 15.sp),
                ),
              ),
              DropdownMenuItem(
                value: true,
                child: CustomText(
                  title: "read".tr(),
                  textStyle: TextStyle(fontSize: 15.sp),
                ),
              ),
              DropdownMenuItem(
                value: false,
                child: CustomText(
                  title: "unread".tr(),
                  textStyle: TextStyle(fontSize: 15.sp),
                ),
              ),
            ],
            onChanged: onFilterChanged,
          ),
        ),
      ],
    );
  }

  void _showCleanupConfirmation(
    BuildContext context,
    NotificationsCubit cubit,
  ) {
    int selectedDays = 30;

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setDialogState) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Container(
              padding: EdgeInsets.all(32.w),
              constraints: BoxConstraints(maxWidth: 480.w),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "cleanup_notifications".tr(),
                    style: TextStyle(
                      fontSize: 26.sp,
                      fontWeight: FontWeight.w900,
                      color: AppColors.mainBlack,
                      letterSpacing: -0.5,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "retention_period".tr(),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w600,
                      color: AppColors.greyLight,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  CustomFilterDropdown<int>(
                    hint: "last_30_days".tr(),
                    value: selectedDays,
                    items: [
                      DropdownMenuItem(
                        value: 7,
                        child: CustomText(
                          title: "last_7_days".tr(),
                          textStyle: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 30,
                        child: CustomText(
                          title: "last_30_days".tr(),
                          textStyle: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                      DropdownMenuItem(
                        value: 90,
                        child: CustomText(
                          title: "last_90_days".tr(),
                          textStyle: TextStyle(fontSize: 15.sp),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        setDialogState(() => selectedDays = value);
                      }
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text(
                    "${"confirmDeleteFile".tr()} ${"notifications".tr()}?",
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: AppColors.mainBlack.withOpacity(0.7),
                      height: 1.4,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "cancel".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: const Color(0xFF6200EE),
                          ),
                        ),
                      ),
                      SizedBox(width: 16.w),
                      TextButton(
                        onPressed: () {
                          cubit.cleanupNotifications(daysRetention: selectedDays);
                          Navigator.pop(context);
                        },
                        child: Text(
                          "delete".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w800,
                            color: AppColors.rejectedColorIndicator,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
