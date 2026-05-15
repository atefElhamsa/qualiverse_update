import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class WeeklyLearningCard extends StatelessWidget {
  final int week;
  final WeekControllers controllers;
  final VoidCallback? onRemove;

  const WeeklyLearningCard({
    super.key,
    required this.week,
    required this.controllers,
    this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF0D47A1).withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
        border: Border.all(color: const Color(0xFF0D47A1).withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF0D47A1).withOpacity(0.12),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Icon(
                  Icons.date_range_rounded,
                  color: const Color(0xFF0D47A1),
                  size: 18.sp,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                "${"week".tr()} $week",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: const Color(0xFF0D47A1),
                  fontSize: 16.sp,
                ),
              ),
              const Spacer(),
              if (onRemove != null)
                InkWell(
                  onTap: onRemove,
                  borderRadius: BorderRadius.circular(50.r),
                  child: Container(
                    padding: EdgeInsets.all(6.r),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.08),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.delete_outline_rounded,
                      color: Colors.red,
                      size: 18.sp,
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 15.h),
          MiniPremiumInput(
            label: "theoretical".tr(),
            icon: Icons.menu_book_rounded,
            controller: controllers.theoretical,
          ),
          MiniPremiumInput(
            label: "training".tr(),
            icon: Icons.handyman_rounded,
            controller: controllers.training,
          ),
          MiniPremiumInput(
            label: "selfLearning".tr(),
            icon: Icons.person_search_rounded,
            controller: controllers.selfLearning,
          ),
          MiniPremiumInput(
            label: "other".tr(),
            icon: Icons.more_horiz_rounded,
            controller: controllers.other,
          ),
        ],
      ),
    );
  }
}
