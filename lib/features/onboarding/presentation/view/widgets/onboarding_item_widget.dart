import 'package:flutter/material.dart';

import '../../../../../routing/all_routes_imports.dart';

class OnboardingItemWidget extends StatelessWidget {
  const OnboardingItemWidget({
    super.key,
    required this.onboardingModel,
    required this.currentIndex,
    required this.pageController,
  });

  final OnboardingModel onboardingModel;
  final int currentIndex;
  final PageController pageController;

  @override
  Widget build(BuildContext context) {
    return ItemPage(
      onboardingModel: onboardingModel,
      currentIndex: currentIndex,
      pageController: pageController,
    );
  }
}
