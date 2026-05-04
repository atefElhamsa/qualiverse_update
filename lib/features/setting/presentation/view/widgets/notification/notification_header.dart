import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/dashboard/presentation/view/widgets/evidence_overview/custom_filter_dropdown.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_state.dart';

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
                      final isEnabled = !isEmpty && hasUnread;

                      return InkWell(
                        onTap: isEnabled ? () => cubit.markAllAsRead() : null,
                        child: CustomText(
                          title: "mark_all_as_read".tr(),
                          textStyle: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: isEnabled
                                ? AppColors.progressColor
                                : AppColors.greyLight.withOpacity(0.5),
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
                  textStyle: TextStyle(fontSize: 14.sp),
                ),
              ),
              DropdownMenuItem(
                value: true,
                child: CustomText(
                  title: "read".tr(),
                  textStyle: TextStyle(fontSize: 14.sp),
                ),
              ),
              DropdownMenuItem(
                value: false,
                child: CustomText(
                  title: "unread".tr(),
                  textStyle: TextStyle(fontSize: 14.sp),
                ),
              ),
            ],
            onChanged: onFilterChanged,
          ),
        ),
      ],
    );
  }
}
