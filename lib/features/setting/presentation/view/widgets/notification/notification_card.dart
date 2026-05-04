import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/utils/app_colors.dart';
import 'package:qualiverse/features/home/data/models/notification_model.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';
import 'action_button.dart';

class NotificationCard extends StatelessWidget {
  final NotificationModel notification;
  final bool isDark;

  const NotificationCard({
    super.key,
    required this.notification,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? const Color(0xFF1E1E2D) : AppColors.white;
    final subtitleColor = isDark ? AppColors.white.withOpacity(0.5) : AppColors.greyLight;
    final titleColor = isDark ? AppColors.white : AppColors.mainBlack;

    final iconColor = _getIconColor(notification.type);
    final iconBg = iconColor.withOpacity(0.1);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: notification.isRead
              ? (isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05))
              : iconColor.withOpacity(0.25),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10.w),
            decoration: BoxDecoration(
              color: iconBg,
              shape: BoxShape.circle,
            ),
            child: Icon(
              _getIconData(notification.type),
              color: iconColor,
              size: 20.sp,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  notification.title,
                  style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w600,
                    color: titleColor,
                  ),
                ),
                SizedBox(height: 3.h),
                Text(
                  notification.message,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: subtitleColor,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Row(
            children: [
              if (!notification.isRead)
                ActionButton(
                  icon: Icons.mark_email_read_rounded,
                  color: AppColors.progressColor,
                  onTap: () {
                    context.read<NotificationsCubit>().markAsRead(id: notification.id);
                  },
                ),
              if (!notification.isRead) SizedBox(width: 8.w),
              ActionButton(
                icon: Icons.delete_rounded,
                color: const Color(0xFFEF4444),
                onTap: () {
                  context.read<NotificationsCubit>().deleteNotification(id: notification.id);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconData _getIconData(String type) {
    switch (type) {
      case 'AssignmentSubmitted':
        return Icons.assignment_turned_in_outlined;
      case 'AssignmentApproved':
        return Icons.check_circle_outline_rounded;
      case 'AssignmentRejected':
        return Icons.cancel_outlined;
      case 'DeadlineApproaching':
        return Icons.warning_amber_rounded;
      case 'NewUser':
        return Icons.person_add_outlined;
      default:
        return Icons.notifications_none_rounded;
    }
  }

  Color _getIconColor(String type) {
    switch (type) {
      case 'AssignmentSubmitted':
        return const Color(0xFF818CF8);
      case 'AssignmentApproved':
        return const Color(0xFF34D399);
      case 'AssignmentRejected':
        return const Color(0xFFF87171);
      case 'DeadlineApproaching':
        return const Color(0xFFFBBF24);
      case 'NewUser':
        return const Color(0xFF60A5FA);
      default:
        return AppColors.progressColor;
    }
  }
}
