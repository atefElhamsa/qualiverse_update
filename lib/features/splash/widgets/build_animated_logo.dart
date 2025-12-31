import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class BuildAnimatedLogo extends StatelessWidget {
  const BuildAnimatedLogo({
    super.key,
    required this.logoController,
    required this.isSmall,
    required this.size,
    required this.logoScaleAnimation,
    required this.logoRotationAnimation,
  });

  final AnimationController logoController;
  final bool isSmall;
  final Size size;
  final Animation<double> logoScaleAnimation;
  final Animation<double> logoRotationAnimation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: logoController,
      builder: (_, _) {
        return Transform.scale(
          scale: logoScaleAnimation.value,
          child: Transform.rotate(
            angle: logoRotationAnimation.value,
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  AppImages.splashImage1,
                  width: isSmall ? size.width * 0.4 : size.width * 0.32,
                  height: isSmall ? size.width * 0.4 : size.width * 0.32,
                  fit: BoxFit.cover,
                ),
                Image.asset(
                  AppImages.logo,
                  width: isSmall ? size.width * 0.3 : size.width * 0.28,
                  height: isSmall ? size.width * 0.3 : size.width * 0.28,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
