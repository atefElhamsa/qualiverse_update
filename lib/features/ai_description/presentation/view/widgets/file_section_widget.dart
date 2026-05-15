import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class FileSectionWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isReady;
  final String actionTitle;
  final IconData actionIcon;
  final VoidCallback onAction;

  const FileSectionWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isReady,
    required this.actionTitle,
    required this.actionIcon,
    required this.onAction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FileBoxWidget(
          title: title,
          icon: icon,
          iconColor: iconColor,
          isReady: isReady,
        ),
        SizedBox(height: 25.h),
        DownloadActionButton(
          title: actionTitle,
          icon: actionIcon,
          onTap: onAction,
        ),
      ],
    );
  }
}
