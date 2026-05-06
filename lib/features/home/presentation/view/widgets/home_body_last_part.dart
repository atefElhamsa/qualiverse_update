import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class HomeBodyLastPart extends StatelessWidget {
  final double screenWidth;

  const HomeBodyLastPart({super.key, required this.screenWidth});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(homeLastItems.length, (index) {
          return Expanded(
            child: CustomHomeLastWidget(homeLastBodyModel: homeLastItems[index])
                .animate()
                .fadeIn(delay: (200 * index).ms, duration: 500.ms)
                .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuad),
          );
        }),
      ),
    );
  }
}
