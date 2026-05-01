import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'notification_card.dart';

class NotificationList extends StatelessWidget {
  final bool isDark;
  const NotificationList({super.key, required this.isDark});

  static final List<NotifData> items = [
    NotifData(icon: Icons.assignment_turned_in_outlined, iconColor: const Color(0xFF6C63FF), iconBg: const Color(0xFFEDE9FF), title: 'تم رفع مؤشر جديد', subtitle: 'قام د. أحمد بتسليم ملف المؤشر 3-1', time: '12 يوليو 2025', isRead: false),
    NotifData(icon: Icons.check_circle_outline_rounded, iconColor: const Color(0xFF22C55E), iconBg: const Color(0xFFDCFCE7), title: 'تمت الموافقة على الدليل', subtitle: 'تم اعتماد الدليل المرفق للمعيار 5', time: '10 يوليو 2025', isRead: false),
    NotifData(icon: Icons.warning_amber_rounded, iconColor: const Color(0xFFF59E0B), iconBg: const Color(0xFFFEF3C7), title: 'اقتراب موعد التسليم', subtitle: 'تبقى 3 أيام على موعد تسليم مؤشر 7-2', time: '8 يوليو 2025', isRead: true),
    NotifData(icon: Icons.cancel_outlined, iconColor: const Color(0xFFEF4444), iconBg: const Color(0xFFFEE2E2), title: 'تم رفض الدليل', subtitle: 'تم رفض الملف المرفق بسبب عدم المطابقة', time: '6 يوليو 2025', isRead: true),
    NotifData(icon: Icons.person_add_alt_1_outlined, iconColor: const Color(0xFF3B82F6), iconBg: const Color(0xFFDBEAFE), title: 'تم تعيين مستخدم جديد', subtitle: 'تم تكليف د. محمد بمؤشر 4-3', time: '4 يوليو 2025', isRead: true),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: items.length,
      separatorBuilder: (_, __) => SizedBox(height: 12.h),
      itemBuilder: (context, index) => NotificationCard(item: items[index], isDark: isDark),
    );
  }
}

class NotifData {
  final IconData icon;
  final Color iconColor, iconBg;
  final String title, subtitle, time;
  final bool isRead;
  const NotifData({required this.icon, required this.iconColor, required this.iconBg, required this.title, required this.subtitle, required this.time, required this.isRead});
}
