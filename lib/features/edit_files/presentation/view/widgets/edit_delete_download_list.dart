import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class EditDeleteDownloadList extends StatelessWidget {
  const EditDeleteDownloadList({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.more_vert, size: 20.sp, color: AppColors.mainBlack),
      color: AppColors.colorButtonLight,
      offset: Offset(0, 50),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      onSelected: (value) {
        switch (value) {
          case 'delete':
            debugPrint("Delete");
            break;
          case 'download':
            debugPrint("Download");
            break;
          case 'edit':
            debugPrint("Edit");
            break;
        }
      },
      itemBuilder: (context) => [
        buildMenuItem(
          value: 'delete',
          icon: Icons.delete_outline,
          text: 'delete',
        ),
        buildMenuItem(
          value: 'download',
          icon: Icons.download,
          text: 'download',
        ),
        buildMenuItem(value: 'edit', icon: Icons.edit, text: 'edit'),
      ],
    );
  }
}

PopupMenuItem<String> buildMenuItem({
  required String value,
  required IconData icon,
  required String text,
}) {
  return PopupMenuItem<String>(
    value: value,
    child: Row(
      children: [
        Icon(icon, color: Colors.white, size: 20),
        SizedBox(width: 10.w),
        CustomText(
          title: text.tr(),
          textStyle: GoogleFonts.cairo(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}
