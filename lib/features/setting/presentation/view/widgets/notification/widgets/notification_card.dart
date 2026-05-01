import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/utils/app_colors.dart';

class NotificationCard extends StatelessWidget {
  final dynamic item;
  final bool isDark;

  const NotificationCard({super.key, required this.item, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final cardColor = isDark ? const Color(0xFF1E1E2D) : AppColors.white;
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
        children: [
          _buildIconBadge(),
          SizedBox(width: 14.w),
          _buildTextContent(titleColor, subtitleColor),
          SizedBox(width: 12.w),
          _buildActions(),
        ],
      ),
    );
  }

  Widget _buildIconBadge() => Container(
    width: 44.w,
    height: 44.w,
    decoration: BoxDecoration(
      color: item.iconBg,
      borderRadius: BorderRadius.circular(12.r),
    ),
    child: Icon(item.icon, color: item.iconColor, size: 22.sp),
  );

  Widget _buildTextContent(Color titleColor, Color subtitleColor) => Expanded(
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
                  fontWeight: item.isRead ? FontWeight.w500 : FontWeight.w700,
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
          style: TextStyle(fontSize: 11.sp, color: subtitleColor),
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
  );

  Widget _buildActions() => Row(
    children: [
      const _ActionBtn(
        icon: Icons.visibility_outlined,
        color: AppColors.drColor,
      ),
      SizedBox(width: 8.w),
      const _ActionBtn(
        icon: Icons.delete_outline_rounded,
        color: Color(0xFFEF4444),
      ),
    ],
  );
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
