import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuildTabBarFilesStatistics extends StatelessWidget {
  const BuildTabBarFilesStatistics({super.key, required this.tabController});
  final TabController tabController;
  
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: const Color(0xFFF1F5F9),
        borderRadius: BorderRadius.circular(15.r),
      ),
      child: TabBar(
        controller: tabController,
        dividerColor: Colors.transparent,
        indicator: BoxDecoration(
          color: const Color(0xFF0F569E),
          borderRadius: BorderRadius.circular(12.r),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey.shade600,
        labelStyle: GoogleFonts.almarai(
          fontWeight: FontWeight.bold,
          fontSize: 15.sp,
        ),
        tabs: [
          Tab(text: "files".tr()),
          Tab(text: "analysis".tr()),
        ],
      ),
    );
  }
}
