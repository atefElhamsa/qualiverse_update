import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../../routing/all_routes_imports.dart';

class NextButton extends StatelessWidget {
  const NextButton({
    super.key,
    required this.currentIndex,
    required this.pageController,
  });

  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: SizedBox(
              height: 50.h,
              width: 200.w,
              child: CustomButton(
                buttonModel: ButtonModel(
                  onPressed: () {
                    if (currentIndex == onboardingList.length - 1) {
                      context.pushNamed(AppRoutes.loginScreen);
                    } else {
                      pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  backgroundColor: AppColors.colorButtonLight,
                  radius: 15,
                  customText: CustomText(
                    title: currentIndex == onboardingList.length - 1
                        ? "start_button".tr()
                        : "onboarding_button_title".tr(),
                    textStyle: Theme.of(
                      context,
                    ).textTheme.titleSmall!.copyWith(color: AppColors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: SmoothPageIndicator(
            controller: pageController,
            count: onboardingList.length,
            effect: WormEffect(
              activeDotColor: AppColors.colorButtonLight,
              dotHeight: MediaQuery.of(context).size.height * 0.015,
              dotWidth: MediaQuery.of(context).size.width * 0.015,
            ),
          ),
        ),
      ],
    );
  }
}
