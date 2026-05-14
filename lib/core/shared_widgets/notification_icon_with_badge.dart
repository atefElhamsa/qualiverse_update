import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class NotificationIconWithBadge extends StatelessWidget {
  final int notificationCount;
  final VoidCallback? onTap;

  const NotificationIconWithBadge({
    super.key,
    this.notificationCount = 0,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCountCubit, NotificationCountState>(
      builder: (context, state) {
        int count = 0;
        if (state is NotificationCountSuccess) {
          count = state.count;
        }
        return InkWell(
          onTap: () {
            context.read<NotificationsCubit>().getRecentNotifications();
            showDialog(
              context: context,
              barrierColor: Colors.black.withOpacity(0.2),
              builder: (dialogContext) => BlocProvider.value(
                value: context.read<NotificationsCubit>(),
                child: NotificationPopup(
                  onViewAll: () {
                    final settingCubit = context.read<SettingCubit>();

                    Future.delayed(const Duration(milliseconds: 100), () {
                      settingCubit.changePage(SettingsPage.notifications);
                      RouterGenerator.mainRoutingInOurApp.pushNamed(
                        AppRoutes.settingScreen,
                      );
                    });
                  },
                ),
              ),
            );
            onTap?.call();
          },
          borderRadius: BorderRadius.circular(50),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(
                Icons.notifications_none_rounded,
                size: 40.sp,
                color: Theme.of(context).brightness == Brightness.dark
                    ? AppColors.white
                    : AppColors.mainBlack,
              ),
              if (count > 0)
                Positioned(
                  right: -2.w,
                  top: -2.h,
                  child: Container(
                    padding: EdgeInsets.all(4.w),
                    decoration: const BoxDecoration(
                      color: AppColors.red,
                      shape: BoxShape.circle,
                    ),
                    constraints: BoxConstraints(
                      minWidth: 18.w,
                      minHeight: 18.w,
                    ),
                    child: Center(
                      child: CustomText(
                        title: count > 9 ? "9+" : count.toString(),
                        textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
