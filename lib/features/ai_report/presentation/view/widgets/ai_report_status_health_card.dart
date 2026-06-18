import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportStatusHealthCard extends StatefulWidget {
  final AiReportHealthModel health;
  final bool isAr;

  const AiReportStatusHealthCard({
    super.key,
    required this.health,
    required this.isAr,
  });

  @override
  State<AiReportStatusHealthCard> createState() =>
      _AiReportStatusHealthCardState();
}

class _AiReportStatusHealthCardState extends State<AiReportStatusHealthCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final health = widget.health;
    final isAr = widget.isAr;
    final bool isOnline = health.status.toLowerCase() == 'ok';
    final serverTime = DateTime.tryParse(health.timestamp) ?? DateTime.now();
    final formattedTime = DateFormat('yyyy-MM-dd HH:mm').format(serverTime);

    final providerName = health.provider.isNotEmpty
        ? health.provider[0].toUpperCase() + health.provider.substring(1).toLowerCase()
        : health.provider;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      width: 220.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20.r,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.grey.withOpacity(0.1)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              children: [
                // Status Badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isAr ? "حالة النظام" : "System Status",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                      decoration: BoxDecoration(
                        color: isOnline
                            ? AppColors.green.withOpacity(0.1)
                            : AppColors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 6.r,
                            height: 6.r,
                            decoration: BoxDecoration(
                              color: isOnline ? AppColors.green : AppColors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          Text(
                            isOnline
                                ? (isAr ? "متصل" : "Online")
                                : (isAr ? "غير متصل" : "Offline"),
                            style: TextStyle(
                              fontSize: 11.sp,
                              fontWeight: FontWeight.bold,
                              color: isOnline ? AppColors.green : AppColors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                // Provider Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isAr ? "المزود النشط" : "Active Provider",
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      providerName.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.mainBlack,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Expandable Details
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: [
                Divider(height: 1.h, color: Colors.grey.shade100),
                Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isAr ? "إصدار الخدمة" : "Version",
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
                          ),
                          Text(
                            health.version,
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColors.mainBlack),
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            isAr ? "توقيت الخادم" : "Server Time",
                            style: TextStyle(fontSize: 11.sp, color: Colors.grey.shade500),
                          ),
                          Text(
                            formattedTime,
                            style: TextStyle(fontSize: 11.sp, fontWeight: FontWeight.w600, color: AppColors.mainBlack),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            crossFadeState: _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 250),
          ),
          
          // Toggle Button
          Divider(height: 1.h, color: Colors.grey.shade100),
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.r),
              bottomRight: Radius.circular(20.r),
            ),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 10.h),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20.r),
                  bottomRight: Radius.circular(20.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _isExpanded 
                        ? (isAr ? "إخفاء التفاصيل" : "Hide Details")
                        : (isAr ? "عرض التفاصيل" : "Show Details"),
                    style: TextStyle(
                      color: AppColors.colorButtonLight,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.sp,
                    ),
                  ),
                  SizedBox(width: 6.w),
                  Icon(
                    _isExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.colorButtonLight,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
