import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiActionButton extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isSecondary;
  final bool isLoading;

  const AiActionButton({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
    this.isSecondary = false,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    bool isRtl = context.locale.languageCode == 'ar';
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: isLoading ? null : onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 16.h),
          decoration: BoxDecoration(
            gradient: isSecondary
                ? null
                : const LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
            color: isSecondary ? Colors.white : null,
            borderRadius: BorderRadius.circular(20.r),
            border: isSecondary
                ? Border.all(
                    color: const Color(0xFF0D47A1).withOpacity(0.2),
                    width: 1.5,
                  )
                : null,
            boxShadow: [
              BoxShadow(
                color: (isSecondary ? Colors.black : const Color(0xFF0D47A1))
                    .withOpacity(0.15),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: isLoading 
              ? SizedBox(
                  height: 24.sp,
                  width: 24.sp,
                  child: CircularProgressIndicator(
                    color: isSecondary ? const Color(0xFF0D47A1) : Colors.white,
                    strokeWidth: 3,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (isSecondary)
                      Icon(
                        isRtl
                            ? Icons.arrow_forward_rounded
                            : Icons.arrow_back_rounded,
                        color: const Color(0xFF0D47A1),
                        size: 22.sp,
                      ),
                    if (isSecondary) SizedBox(width: 12.w),
                    Text(
                      title,
                      style: TextStyle(
                        color: isSecondary ? const Color(0xFF0D47A1) : Colors.white,
                        fontWeight: FontWeight.w900,
                        fontSize: 18.sp,
                        letterSpacing: isRtl ? 0 : 0.5,
                      ),
                    ),
                    if (!isSecondary) SizedBox(width: 12.w),
                    if (!isSecondary) Icon(icon, color: Colors.white, size: 22.sp),
                  ],
                ),
        ),
      ),
    );
  }
}
