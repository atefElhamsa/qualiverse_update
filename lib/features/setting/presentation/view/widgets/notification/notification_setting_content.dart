import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../routing/all_routes_imports.dart';

class NotificationSettingsContent extends StatelessWidget {
  const NotificationSettingsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).scaffoldBackgroundColor != AppColors.white;

    return Padding(
      padding: EdgeInsetsDirectional.only(start: 40.w, top: 50.h, end: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Header Row ──
          Row(
            children: [
              Column(
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
                  Text(
                    'notificationSubtitle'.tr(),
                    style: TextStyle(
                      fontSize: 13.sp,
                      color: isDark
                          ? AppColors.white.withOpacity(0.5)
                          : AppColors.greyLight,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              // Theme toggle chip
              const _ThemeToggleChip(),
            ],
          ),

          SizedBox(height: 24.h),

          // ── Notification List ──
          Expanded(child: _NotificationList(isDark: isDark)),
        ],
      ),
    );
  }
}

// ── Theme Toggle ─────────────────────────────────────────────────────────────
class _ThemeToggleChip extends StatelessWidget {
  const _ThemeToggleChip();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingCubit, SettingState>(
      builder: (context, state) {
        final cubit = SettingCubit.get(context);
        final isDark = cubit.isDark;
        return GestureDetector(
          onTap: () => cubit.changeTheme(dark: !isDark),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.drColor.withOpacity(0.15)
                  : const Color(0xFFEEF2FF),
              borderRadius: BorderRadius.circular(30.r),
              border: Border.all(
                color: isDark
                    ? AppColors.drColor.withOpacity(0.4)
                    : AppColors.drColor.withOpacity(0.25),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isDark ? Icons.nights_stay_rounded : Icons.wb_sunny_rounded,
                  size: 18.sp,
                  color: AppColors.drColor,
                ),
                SizedBox(width: 8.w),
                Text(
                  isDark ? 'dark'.tr() : 'light'.tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.drColor,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ── Notification List ─────────────────────────────────────────────────────────
class _NotificationList extends StatelessWidget {
  final bool isDark;
  const _NotificationList({required this.isDark});

  // Dummy data
  static final List<_NotifData> _items = [
    _NotifData(
      icon: Icons.assignment_turned_in_outlined,
      iconColor: const Color(0xFF6C63FF),
      iconBg: const Color(0xFFEDE9FF),
      title: 'تم رفع مؤشر جديد',
      subtitle: 'قام د. أحمد بتسليم ملف المؤشر 3-1',
      time: '12 يوليو 2025',
      isRead: false,
    ),
    _NotifData(
      icon: Icons.check_circle_outline_rounded,
      iconColor: const Color(0xFF22C55E),
      iconBg: const Color(0xFFDCFCE7),
      title: 'تمت الموافقة على الدليل',
      subtitle: 'تم اعتماد الدليل المرفق للمعيار 5',
      time: '10 يوليو 2025',
      isRead: false,
    ),
    _NotifData(
      icon: Icons.warning_amber_rounded,
      iconColor: const Color(0xFFF59E0B),
      iconBg: const Color(0xFFFEF3C7),
      title: 'اقتراب موعد التسليم',
      subtitle: 'تبقى 3 أيام على موعد تسليم مؤشر 7-2',
      time: '8 يوليو 2025',
      isRead: true,
    ),
    _NotifData(
      icon: Icons.cancel_outlined,
      iconColor: const Color(0xFFEF4444),
      iconBg: const Color(0xFFFEE2E2),
      title: 'تم رفض الدليل',
      subtitle: 'تم رفض الملف المرفق بسبب عدم المطابقة',
      time: '6 يوليو 2025',
      isRead: true,
    ),
    _NotifData(
      icon: Icons.person_add_alt_1_outlined,
      iconColor: const Color(0xFF3B82F6),
      iconBg: const Color(0xFFDBEAFE),
      title: 'تم تعيين مستخدم جديد',
      subtitle: 'تم تكليف د. محمد بمؤشر 4-3',
      time: '4 يوليو 2025',
      isRead: true,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: _items.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        return _NotificationCard(item: _items[index], isDark: isDark);
      },
    );
  }
}

class _NotifData {
  final IconData icon;
  final Color iconColor;
  final Color iconBg;
  final String title;
  final String subtitle;
  final String time;
  final bool isRead;

  const _NotifData({
    required this.icon,
    required this.iconColor,
    required this.iconBg,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.isRead,
  });
}

// ── Notification Card ─────────────────────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final _NotifData item;
  final bool isDark;

  const _NotificationCard({required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark
        ? const Color(0xFF1E1E2D)
        : AppColors.white;
    final subtitleColor = isDark
        ? AppColors.white.withOpacity(0.5)
        : AppColors.greyLight;
    final titleColor = isDark ? AppColors.white : AppColors.mainBlack;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(
          color: item.isRead
              ? (isDark
                  ? Colors.white.withOpacity(0.05)
                  : Colors.black.withOpacity(0.05))
              : item.iconColor.withOpacity(0.25),
          width: item.isRead ? 1 : 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.2 : 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Icon badge
          Container(
            width: 44.w,
            height: 44.w,
            decoration: BoxDecoration(
              color: item.iconBg,
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Icon(item.icon, color: item.iconColor, size: 22.sp),
          ),
          SizedBox(width: 14.w),

          // Text content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: item.isRead
                              ? FontWeight.w500
                              : FontWeight.w700,
                          color: titleColor,
                        ),
                      ),
                    ),
                    if (!item.isRead)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: item.iconColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                SizedBox(height: 3.h),
                Text(
                  item.subtitle,
                  style: TextStyle(
                    fontSize: 11.sp,
                    color: subtitleColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  item.time,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: subtitleColor.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // Action buttons
          Row(
            children: [
              _ActionBtn(
                icon: Icons.visibility_outlined,
                color: AppColors.drColor,
              ),
              SizedBox(width: 8.w),
              _ActionBtn(
                icon: Icons.delete_outline_rounded,
                color: const Color(0xFFEF4444),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ActionBtn extends StatelessWidget {
  final IconData icon;
  final Color color;

  const _ActionBtn({required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34.w,
      height: 34.w,
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Icon(icon, color: color, size: 17.sp),
    );
  }
}
