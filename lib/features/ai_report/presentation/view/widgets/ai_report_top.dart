import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AiReportTop extends StatelessWidget {
  final bool hideHistory;
  final bool disableSidebar;

  const AiReportTop({
    super.key,
    this.hideHistory = false,
    this.disableSidebar = false,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return SizedBox(
      width: double.infinity,
      height: 240.h,
      child: Stack(
        children: [
          CustomScaffoldTop(
            controller: inherited.controller,
            isDisabled: disableSidebar,
          ),
          Positioned(
            top: 40.h,
            left: 0,
            right: 0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF0D47A1), Color(0xFF1976D2)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ).createShader(bounds),
                  child: Text(
                    "aiModel".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge!.copyWith(
                      fontSize: 42.sp,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.2,
                      height: 1.4,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0D47A1).withOpacity(0.08),
                        const Color(0xFF1976D2).withOpacity(0.04),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(100.r),
                    border: Border.all(
                      color: const Color(0xFF0D47A1).withOpacity(0.15),
                      width: 1.2,
                    ),
                  ),
                  child: Text(
                    "report".tr().toUpperCase(),
                    style: Theme.of(context).textTheme.labelLarge!.copyWith(
                      fontSize: 18.sp,
                      color: const Color(0xFF0D47A1),
                      fontWeight: FontWeight.w800,
                      letterSpacing: context.locale.languageCode == 'ar'
                          ? 0
                          : 3.0,
                      height: context.locale.languageCode == 'ar' ? 1.4 : 1.1,
                    ),
                  ),
                ),
                if (!hideHistory) ...[
                  SizedBox(height: 16.h),
                  InkWell(
                    onTap: () {
                      context.push(AppRoutes.aiReportHistoryScreen);
                    },
                    borderRadius: BorderRadius.circular(20.r),
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 8.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppColors.aiPrimary.withOpacity(0.3),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.aiPrimary.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.history,
                            size: 20.sp,
                            color: AppColors.aiPrimary,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            context.locale.languageCode == 'ar'
                                ? 'سجل التقارير'
                                : 'Reports History',
                            style: Theme.of(context).textTheme.labelMedium!
                                .copyWith(
                                  color: AppColors.aiPrimary,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14.sp,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

