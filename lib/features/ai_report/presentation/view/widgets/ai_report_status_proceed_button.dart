import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/app_routes.dart';

class AiReportStatusProceedButton extends StatelessWidget {
  final bool isAr;
  final String? selectedProvider;
  final String? selectedCourseNature;

  const AiReportStatusProceedButton({
    super.key,
    required this.isAr,
    required this.selectedProvider,
    required this.selectedCourseNature,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            context.pushNamed(
              AppRoutes.aiReportScreen,
              extra: {
                'provider': selectedProvider,
                'courseNature': selectedCourseNature,
              },
            );
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 14.h),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(50.r),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1565C0).withOpacity(0.28),
                  blurRadius: 18,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.upload_file_rounded,
                  color: Colors.white,
                  size: 20.sp,
                ),
                SizedBox(width: 10.w),
                Text(
                  isAr ? "المتابعة لرفع الملفات" : "Proceed to Upload",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 15.sp,
                    letterSpacing: 0.4,
                  ),
                ),
                SizedBox(width: 10.w),
                Icon(
                  isAr
                      ? Icons.arrow_back_ios_new_rounded
                      : Icons.arrow_forward_ios_rounded,
                  color: Colors.white.withOpacity(0.85),
                  size: 14.sp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
