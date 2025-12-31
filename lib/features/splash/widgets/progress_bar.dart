import 'package:flutter/material.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';

class ProgressBar extends StatelessWidget {
  const ProgressBar({
    super.key,
    required this.isSmall,
    required this.progressAnimation,
  });

  final bool isSmall;
  final Animation<double> progressAnimation;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: isSmall ? 150 : 400),
      child: AnimatedBuilder(
        animation: progressAnimation,
        builder: (_, _) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: progressAnimation.value,
              backgroundColor: AppColors.greyLight.withOpacity(0.75),
              valueColor: const AlwaysStoppedAnimation(AppColors.progressColor),
              minHeight: 8,
            ),
          );
        },
      ),
    );
  }
}
