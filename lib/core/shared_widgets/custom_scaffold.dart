import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({super.key, required this.widget, this.onRefresh});
  final Widget widget;
  final Future<void> Function()? onRefresh;
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    Locale locale = WidgetsBinding.instance.platformDispatcher.locale;
    final scrollView = SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: widget,
    );
    return Container(
      width: screenWidth,
      height: screenHeight,
      padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 25.h),
      decoration: Theme.of(context).scaffoldBackgroundColor == AppColors.white
          ? const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [AppColors.scaffoldLight1, AppColors.colorButtonLight],
              ),
            )
          : const BoxDecoration(color: AppColors.mainBlack),
      child: Container(
        width: screenWidth,
        height: screenHeight,
        padding: EdgeInsets.only(
          left: locale == const Locale('ar') ? 0 : 27.w,
          right: locale == const Locale('ar') ? 0 : 27.w,
        ),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
              ? AppColors.white
              : AppColors.mainBlack,
          borderRadius: BorderRadius.circular(23.r),
        ),
        child: onRefresh != null
            ? RefreshIndicator(
                onRefresh: onRefresh!,
                color: AppColors.colorButtonLight,
                child: scrollView,
              )
            : scrollView,
      ),
    );
  }
}
