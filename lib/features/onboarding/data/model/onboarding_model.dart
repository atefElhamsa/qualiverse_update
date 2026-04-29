import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class OnboardingModel {
  final String title;
  final String description;
  final String image;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.image,
  });
}

List<OnboardingModel> onboardingList = [
  OnboardingModel(
    title: "onboardingPage1Title",
    description: "onboardingPage1Desc",
    image: AppImages.projectDefinitionOnboarding,
  ),
  OnboardingModel(
    title: "onboardingPage2Title",
    description: "onboardingPage2Desc",
    image: AppImages.academicImageOnboarding,
  ),
  OnboardingModel(
    title: "onboardingPage3Title",
    description: "onboardingPage3Desc",
    image: AppImages.courseImageOnboarding,
  ),
  OnboardingModel(
    title: "onboardingPage4Title",
    description: "onboardingPage4Desc",
    image: AppImages.performanceImageOnboarding,
  ),
];
