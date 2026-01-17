import 'package:flutter/material.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class OnboardingBody extends StatefulWidget {
  const OnboardingBody({super.key});

  @override
  State<OnboardingBody> createState() => _OnboardingBodyState();
}

class _OnboardingBodyState extends State<OnboardingBody> {
  PageController pageController = PageController();
  int currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return OnboardingScaffold(
      widget: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: onboardingList.length,
            onPageChanged: (value) {
              setState(() {
                currentIndex = value;
              });
            },
            itemBuilder: (context, index) {
              return OnboardingItemWidget(
                onboardingModel: onboardingList[index],
                currentIndex: currentIndex,
                pageController: pageController,
              );
            },
          ),
          SkipButton(
            pageController: pageController,
            currentIndex: currentIndex,
          ),
          NextButton(
            currentIndex: currentIndex,
            pageController: pageController,
          ),
        ],
      ),
    );
  }
}
