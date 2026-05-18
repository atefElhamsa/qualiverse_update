import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DownloadActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback? onTap;

  const DownloadActionButton({
    super.key,
    required this.title,
    required this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDisabled = onTap == null;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 45.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.grey.shade100 : Colors.white,
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(
            color: isDisabled
                ? Colors.grey.shade400
                : AppColors.aiPrimary.withOpacity(0.6),
            width: 1.5,
          ),
          boxShadow: isDisabled
              ? []
              : [
                  BoxShadow(
                    color: AppColors.aiPrimary.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isDisabled ? Colors.grey : AppColors.aiPrimary,
              size: 24.sp,
            ),
            SizedBox(width: 14.w),
            Text(
              title,
              style: GoogleFonts.almarai(
                color: isDisabled ? Colors.grey : AppColors.aiPrimary,
                fontSize: 19.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
