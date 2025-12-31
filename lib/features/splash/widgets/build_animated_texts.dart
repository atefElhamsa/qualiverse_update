import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class BuildAnimatedTexts extends StatelessWidget {
  const BuildAnimatedTexts({
    super.key,
    required this.textController,
    required this.textFadeAnimation,
    required this.textSlideAnimation,
    required this.isSmall,
  });

  final AnimationController textController;
  final Animation<double> textFadeAnimation;
  final Animation<Offset> textSlideAnimation;
  final bool isSmall;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: textController,
      builder: (_, _) {
        return FadeTransition(
          opacity: textFadeAnimation,
          child: SlideTransition(
            position: textSlideAnimation,
            child: Column(
              children: [
                CustomText(
                  title: AppTexts.accreditationQualitySystemEnglish,
                  textStyle: Theme.of(context).textTheme.displayLarge!,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                CustomText(
                  title: AppTexts.accreditationQualitySystemArabic,
                  textStyle: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontSize: 40.sp,
                    color: AppColors.whiteGrey,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
