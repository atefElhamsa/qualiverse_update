import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportStatusErrorWidget extends StatelessWidget {
  final String error;
  final bool isAr;
  final VoidCallback? onRetry;

  const AiReportStatusErrorWidget({
    super.key,
    required this.error,
    required this.isAr,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    // Check if the error is an ngrok offline error
    final isOfflineError =
        error.contains('ngrok') ||
        error.contains('offline') ||
        error.contains('3200') ||
        error.contains('Failed host');

    final title = isOfflineError
        ? (isAr ? "الذكاء الاصطناعي أوفلاين" : "AI Model is Offline")
        : (isAr ? "حدث خطأ غير متوقع" : "Unexpected Error");

    final message = isOfflineError
        ? (isAr
              ? "عذراً، خوادم الذكاء الاصطناعي مغلقة حالياً. يرجى المحاولة في وقت لاحق."
              : "Sorry, the AI model servers are currently offline. Please try again later.")
        : (isAr
              ? "واجهنا مشكلة أثناء الاتصال بالخادم. تفاصيل الخطأ:\n$error"
              : "We encountered a problem connecting to the server. Details:\n$error");

    final icon = isOfflineError
        ? Icons.cloud_off_rounded
        : Icons.error_outline_rounded;
    final iconColor = isOfflineError ? Colors.orangeAccent : AppColors.red;
    final bgColor = isOfflineError
        ? Colors.orange.shade50
        : AppColors.red.withOpacity(0.05);
    final borderColor = isOfflineError
        ? Colors.orange.withOpacity(0.3)
        : AppColors.red.withOpacity(0.3);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 30.h),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(30.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24.r),
          boxShadow: [
            BoxShadow(
              color: iconColor.withOpacity(0.1),
              blurRadius: 30,
              spreadRadius: 10,
              offset: const Offset(0, 15),
            ),
          ],
          border: Border.all(color: borderColor, width: 2),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.all(20.r),
              decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 60.sp),
            ),
            SizedBox(height: 25.h),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                fontWeight: FontWeight.w900,
                color: Colors.black87,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(height: 12.h),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.grey.shade600,
                height: 1.5,
                fontSize: 15.sp,
              ),
            ),
            SizedBox(height: 35.h),
            ElevatedButton.icon(
              onPressed:
                  onRetry ??
                  () => context.read<AiReportStatusCubit>().fetchStatus(),
              icon: Icon(
                Icons.refresh_rounded,
                color: Colors.white,
                size: 22.sp,
              ),
              label: Text(
                isAr ? "تحديث الصفحة" : "Refresh",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.colorButtonLight,
                foregroundColor: Colors.white,
                elevation: 5,
                shadowColor: AppColors.colorButtonLight.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
                minimumSize: Size(double.infinity, 55.h),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
