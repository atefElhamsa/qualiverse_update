import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class SplashBody extends StatelessWidget {
  const SplashBody({
    super.key,
    required this.isSmall,
    required this.size,
    required this.logoController,
    required this.logoScaleAnimation,
    required this.logoRotationAnimation,
    required this.textController,
    required this.textFadeAnimation,
    required this.textSlideAnimation,
    required this.progressAnimation,
  });

  final bool isSmall;
  final Size size;
  final AnimationController logoController;
  final Animation<double> logoScaleAnimation;
  final Animation<double> logoRotationAnimation;
  final AnimationController textController;
  final Animation<double> textFadeAnimation;
  final Animation<Offset> textSlideAnimation;
  final Animation<double> progressAnimation;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [AppColors.mainBlack, AppColors.mainBlack]
              : [AppColors.splashBackground2, AppColors.splashBackground1],
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const Spacer(flex: 2),
            BuildAnimatedLogo(
              logoController: logoController,
              isSmall: isSmall,
              size: size,
              logoScaleAnimation: logoScaleAnimation,
              logoRotationAnimation: logoRotationAnimation,
            ),
            const SizedBox(height: 40),
            BuildAnimatedTexts(
              textController: textController,
              textFadeAnimation: textFadeAnimation,
              textSlideAnimation: textSlideAnimation,
              isSmall: isSmall,
            ),
            const Spacer(flex: 2),
            ProgressBar(isSmall: isSmall, progressAnimation: progressAnimation),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
