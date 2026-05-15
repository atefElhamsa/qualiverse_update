import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class FileBoxWidget extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color iconColor;
  final bool isReady;

  const FileBoxWidget({
    super.key,
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.isReady,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
      options: RoundedRectDottedBorderOptions(
        color: isReady ? Colors.transparent : AppColors.greyLight,
        strokeWidth: 1.2,
        dashPattern: const [8, 5],
        radius: Radius.circular(24.r),
      ),
      child: Container(
        width: 350.w,
        height: 160.h,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.white, iconColor.withOpacity(0.02)],
          ),
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: isReady
              ? [
                  BoxShadow(
                    color: iconColor.withOpacity(0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ]
              : [],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 50.sp, color: iconColor),
            ),
            SizedBox(height: 10.h),
            if (isReady) _buildFileNameLabel() else _buildPreparingLabel(),
          ],
        ),
      ),
    );
  }

  Widget _buildFileNameLabel() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.check_circle_rounded,
            color: AppColors.aiSuccess,
            size: 16,
          ),
          SizedBox(width: 8.w),
          Flexible(
            child: Text(
              title,
              style: GoogleFonts.almarai(
                color: AppColors.textFieldDark,
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPreparingLabel() {
    return Text(
      "preparing".tr(),
      style: GoogleFonts.almarai(
        color: AppColors.greyLight,
        fontSize: 16.sp,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
