import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SkipButton extends StatelessWidget {
  const SkipButton({
    super.key,
    required this.pageController,
    required this.currentIndex,
  });

  final PageController pageController;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    if (currentIndex == onboardingList.length - 1) {
      return const SizedBox.shrink();
    }
    return Positioned(
      top: 15.h,
      right: 20.w,
      child: TextButton(
        onPressed: () {
          pageController.animateToPage(
            onboardingList.length - 1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        },
        child: CustomText(
          title: "skip".tr(),
          textStyle: Theme.of(
            context,
          ).textTheme.titleSmall!.copyWith(color: AppColors.greyLight),
        ),
      ),
    );
  }
}
