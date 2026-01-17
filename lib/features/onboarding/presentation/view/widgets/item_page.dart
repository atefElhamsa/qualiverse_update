import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class ItemPage extends StatelessWidget {
  const ItemPage({
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 15.h),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.r),
                      child: Image.asset(
                        onboardingModel.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: CustomText(
                    title: onboardingModel.title.tr(),
                    textStyle: Theme.of(context).textTheme.headlineSmall!,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: CustomText(
                    title: onboardingModel.description.tr(),
                    textStyle: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(color: AppColors.greyLight),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
