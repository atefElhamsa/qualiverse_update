import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';
import 'notification_header.dart';
import 'notification_list_view.dart';

class NotificationSettingsContent extends StatefulWidget {
  const NotificationSettingsContent({super.key});

  @override
  State<NotificationSettingsContent> createState() =>
      _NotificationSettingsContentState();
}

class _NotificationSettingsContentState
    extends State<NotificationSettingsContent> {
  bool? selectedFilter;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<NotificationsCubit>();
    if (cubit.allNotifications.isEmpty) {
      cubit.getAllNotifications();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 40.w, top: 50.h, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          NotificationHeader(
            isDark: isDark,
            selectedFilter: selectedFilter,
            onFilterChanged: (value) {
              setState(() => selectedFilter = value);
              context.read<NotificationsCubit>().getAllNotifications(
                isRead: value,
              );
            },
          ),
          SizedBox(height: 16.h),
          Expanded(child: NotificationListView(isDark: isDark)),
        ],
      ),
    );
  }
}
