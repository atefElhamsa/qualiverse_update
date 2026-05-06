import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class HomeBodyFirstPart extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isDrawerVisible;

  const HomeBodyFirstPart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.isDrawerVisible,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isDrawerVisible)
            CustomScaffoldHome(controller: inherited.controller)
                .animate()
                .fadeIn(duration: 500.ms)
                .slideX(begin: -0.2, end: 0)
          else
            const SizedBox(),
          const Spacer(),
          IconButton(
            onPressed: () {
              final cubit = SettingCubit.get(context);
              if (context.locale.languageCode == 'en') {
                cubit.changeLanguage(lang: 'ar', context: context);
              } else {
                cubit.changeLanguage(lang: 'en', context: context);
              }
            },
            icon: Icon(
              Icons.language_rounded,
              color: AppColors.mainBlack,
              size: 28.sp,
            ),
          ).animate().fadeIn(delay: 100.ms).scale(curve: Curves.easeOutBack),
          const SizedBox(width: 8),
          const NotificationIconWithBadge(notificationCount: 3)
              .animate()
              .fadeIn(delay: 200.ms)
              .scale(curve: Curves.easeOutBack),
          const SizedBox(width: 16),
          _buildPillButton(
            context,
            title: "accreditation",
            color: AppColors.progressColor,
            onPressed: () => context.pushNamed(AppRoutes.accreditationScreen),
            delay: 300.ms,
          ),
          const SizedBox(width: 16),
          _buildPillButton(
            context,
            title: "aiModel",
            color: AppColors.aiModelColor,
            onPressed: () => context.pushNamed(AppRoutes.aiMainScreen),
            delay: 400.ms,
          ),
        ],
      ),
    );
  }

  Widget _buildPillButton(
    BuildContext context, {
    required String title,
    required Color color,
    required VoidCallback onPressed,
    required Duration delay,
  }) {
    return SizedBox(
      width: 200.w,
      height: 65.h,
      child: CustomButton(
        buttonModel: ButtonModel(
          onPressed: onPressed,
          backgroundColor: color,
          radius: 32.5,
          customText: FittedBox(
            fit: BoxFit.scaleDown,
            child: CustomText(
              title: title.tr(),
              textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
            ),
          ),
        ),
      ),
    ).animate().fadeIn(delay: delay).slideX(begin: 0.1, end: 0);
  }
}
