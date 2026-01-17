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
    title: "onboarding_page_1_title",
    description: "onboarding_page_1_desc",
    image: AppImages.projectDefinitionOnboarding,
  ),
  OnboardingModel(
    title: "onboarding_page_2_title",
    description: "onboarding_page_2_desc",
    image: AppImages.academicImageOnboarding,
  ),
  OnboardingModel(
    title: "onboarding_page_3_title",
    description: "onboarding_page_3_desc",
    image: AppImages.courseImageOnboarding,
  ),
  OnboardingModel(
    title: "onboarding_page_4_title",
    description: "onboarding_page_4_desc",
    image: AppImages.performanceImageOnboarding,
  ),
];
