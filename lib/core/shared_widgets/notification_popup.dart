import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class NotificationPopup extends StatelessWidget {
  final VoidCallback? onViewAll;
  const NotificationPopup({super.key, this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      alignment: AlignmentDirectional.topStart,
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: EdgeInsetsDirectional.only(
        top: 55.h,
        start: 350.w,
      ).resolve(Directionality.of(context)),
      child: Container(
        width: 360.w,
        constraints: BoxConstraints(maxHeight: 550.h),
        decoration: _popupDecoration(context),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const _PopupHeader(),
            const Divider(height: 1),
            const _NotificationsList(),
            const Divider(height: 1),
            _PopupFooter(onViewAll: onViewAll),
          ],
        ),
      ),
    );
  }

  BoxDecoration _popupDecoration(BuildContext context) => BoxDecoration(
    color: Theme.of(context).cardColor,
    borderRadius: BorderRadius.circular(24.r),
    boxShadow: const [
      BoxShadow(color: Colors.black12, blurRadius: 20, offset: Offset(0, 10)),
    ],
  );
}

class _PopupHeader extends StatelessWidget {
  const _PopupHeader();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20.w, 20.h, 12.w, 12.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.notifications_active_rounded,
                color: AppColors.progressColor,
                size: 22.sp,
              ),
              SizedBox(width: 10.w),
              CustomText(
                title: "notifications".tr(),
                textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                ),
              ),
            ],
          ),
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(
              Icons.close_rounded,
              size: 20.sp,
              color: AppColors.greyLight,
            ),
          ),
        ],
      ),
    );
  }
}

class _NotificationsList extends StatelessWidget {
  const _NotificationsList();

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        builder: (context, state) {
          if (state is NotificationsLoading) return const _LoadingState();
          if (state is NotificationsError) {
            return _ErrorState(message: state.message);
          }

          final notifications = (state is NotificationsSuccess)
              ? state.notifications
              : <NotificationModel>[];
          if (notifications.isEmpty) return const _EmptyState();

          return ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(vertical: 8.h),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => SizedBox(height: 4.h),
            itemBuilder: (_, index) =>
                _NotificationItem(notification: notifications[index]),
          );
        },
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final NotificationModel notification;
  const _NotificationItem({required this.notification});

  @override
  Widget build(BuildContext context) {
    final bool isUnread = !notification.isRead;
    final typeConfig = notification.type.toNotificationConfig();

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w),
      decoration: BoxDecoration(
        color: isUnread
            ? AppColors.progressColor.withOpacity(0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(12.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBadge(config: typeConfig),
              SizedBox(width: 12.w),
              Expanded(
                child: _NotificationContent(
                  notification: notification,
                  isUnread: isUnread,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _IconBadge extends StatelessWidget {
  final ({IconData icon, Color color}) config;
  const _IconBadge({required this.config});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: config.color.withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(config.icon, color: config.color, size: 15.sp),
    );
  }
}

class _NotificationContent extends StatelessWidget {
  final NotificationModel notification;
  final bool isUnread;

  const _NotificationContent({
    required this.notification,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomText(
                title: notification.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textStyle: Theme.of(context).textTheme.titleSmall!.copyWith(
                  fontWeight: isUnread ? FontWeight.bold : FontWeight.w600,
                  fontSize: 15.sp,
                  color: isUnread ? AppColors.mainBlack : AppColors.greyLight,
                ),
              ),
            ),
            if (isUnread)
              Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: AppColors.progressColor,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
        SizedBox(height: 4.h),
        CustomText(
          title: notification.message,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          textStyle: Theme.of(context).textTheme.bodySmall!.copyWith(
            color: isUnread
                ? AppColors.mainBlack.withOpacity(0.8)
                : AppColors.greyLight,
            fontSize: 13.sp,
            height: 1.3,
          ),
        ),
        SizedBox(height: 8.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Icon(
                  Icons.access_time_rounded,
                  size: 10.sp,
                  color: AppColors.greyLight.withOpacity(0.5),
                ),
                SizedBox(width: 4.w),
                CustomText(
                  title: notification.timeAgo,
                  textStyle: TextStyle(
                    fontSize: 10.sp,
                    color: AppColors.greyLight,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            CustomText(
              title: notification.formattedCreatedOn,
              textStyle: TextStyle(
                fontSize: 9.sp,
                color: AppColors.greyLight.withOpacity(0.6),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _PopupFooter extends StatelessWidget {
  final VoidCallback? onViewAll;
  const _PopupFooter({this.onViewAll});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.w),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
          onViewAll?.call();
        },
        borderRadius: BorderRadius.circular(12.r),
        splashColor: AppColors.progressColor.withOpacity(0.1),
        highlightColor: Colors.transparent,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 12.h),
          decoration: BoxDecoration(
            color: AppColors.progressColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                title: "view_all".tr(),
                textStyle: TextStyle(
                  fontSize: 15.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.progressColor,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 13.sp,
                color: AppColors.progressColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoadingState extends StatelessWidget {
  const _LoadingState();
  @override
  Widget build(BuildContext context) => SizedBox(
    height: 200.h,
    child: const Center(child: CircularProgressIndicator()),
  );
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.symmetric(vertical: 40.h),
    child: Column(
      children: [
        Icon(
          Icons.notifications_off_outlined,
          size: 50.sp,
          color: AppColors.greyLight.withOpacity(0.5),
        ),
        SizedBox(height: 16.h),
        CustomText(
          title: "no_notifications".tr(),
          textStyle: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: AppColors.greyLight),
        ),
      ],
    ),
  );
}

class _ErrorState extends StatelessWidget {
  final String message;
  const _ErrorState({required this.message});
  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(24.w),
    child: CustomText(
      title: message,
      textStyle: const TextStyle(color: AppColors.red, fontSize: 13),
    ),
  );
}

extension NotificationTypeExt on String {
  ({IconData icon, Color color}) toNotificationConfig() {
    switch (this) {
      case 'AssignmentSubmitted':
        return (icon: Icons.file_present_rounded, color: Colors.blue);
      case 'AssignmentApproved':
        return (icon: Icons.check_circle_outline_rounded, color: Colors.green);
      case 'AssignmentRejected':
        return (icon: Icons.error_outline_rounded, color: Colors.red);
      default:
        return (
          icon: Icons.notifications_none_rounded,
          color: AppColors.progressColor,
        );
    }
  }
}
