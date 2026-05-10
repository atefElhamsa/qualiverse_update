import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'mini_premium_input.dart';

class WeeklyLearningCard extends StatelessWidget {
  final int week;

  const WeeklyLearningCard({super.key, required this.week});

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
            ],
          ),
          SizedBox(height: 15.h),
          MiniPremiumInput(
            label: "theoretical".tr(),
            icon: Icons.menu_book_rounded,
          ),
          MiniPremiumInput(
            label: "training".tr(),
            icon: Icons.handyman_rounded,
          ),
          MiniPremiumInput(
            label: "selfLearning".tr(),
            icon: Icons.person_search_rounded,
          ),
          MiniPremiumInput(
            label: "other".tr(),
            icon: Icons.more_horiz_rounded,
          ),
        ],
      ),
    );
  }
}
