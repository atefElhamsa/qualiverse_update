import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_cubit.dart';
import 'package:qualiverse/features/home/presentation/controller/notifications_state.dart';
import 'package:qualiverse/features/home/presentation/controller/notification_count_cubit.dart';
import 'package:qualiverse/features/login/presentation/view/widgets/error_widget.dart';
import 'notification_card.dart';

class NotificationListView extends StatelessWidget {
  final bool isDark;

  const NotificationListView({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NotificationsCubit, NotificationsState>(
      listener: (context, state) {
        if (state is NotificationActionSuccess) {
          showSnackBar(context, state.message, Colors.green);
          context.read<NotificationCountCubit>().getUnreadCount();
        } else if (state is NotificationActionError) {
          showSnackBar(context, state.message, Colors.red);
        }
      },
      child: BlocBuilder<NotificationsCubit, NotificationsState>(
        buildWhen: (previous, current) =>
            current is NotificationsSuccess ||
            current is NotificationsLoading ||
            current is NotificationsPaginationLoading ||
            current is NotificationsError,
        builder: (context, state) {
          final cubit = context.read<NotificationsCubit>();
          final notifications = cubit.allNotifications;
          final hasMore = cubit.hasMore;

          if (state is NotificationsLoading && notifications.isEmpty) {
            return const Center(child: CustomLoading());
          }

          return Column(
            children: [
              Expanded(
                child: notifications.isEmpty
                    ? Center(
                        child: CustomText(
                          title: "no_notifications".tr(),
                          textStyle: TextStyle(
                            fontSize: 16.sp,
                            color: AppColors.greyLight,
                          ),
                        ),
                      )
                    : ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.only(bottom: 30.h),
                        itemCount: notifications.length,
                        separatorBuilder: (_, __) => SizedBox(height: 12.h),
                        itemBuilder: (context, index) {
                          return NotificationCard(
                            notification: notifications[index],
                            isDark: isDark,
                          );
                        },
                      ),
              ),
              if (hasMore && notifications.isNotEmpty)
                _ViewMoreButton(state: state, cubit: cubit),
            ],
          );
        },
      ),
    );
  }
}

class _ViewMoreButton extends StatelessWidget {
  final NotificationsState state;
  final NotificationsCubit cubit;

  const _ViewMoreButton({required this.state, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: state is NotificationsPaginationLoading
          ? const Center(child: CircularProgressIndicator())
          : InkWell(
              onTap: () => cubit.getAllNotifications(loadMore: true),
              child: Center(
                child: CustomText(
                  title: "view_more".tr(),
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.progressColor,
                  ),
                ),
              ),
            ),
    );
  }
}
