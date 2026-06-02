import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class CustomShimmer extends StatelessWidget {
  final double? width;
  final double? height;
  final BorderRadiusGeometry borderRadius;
  final Color? baseColor;
  final Color? highlightColor;

  const CustomShimmer({
    super.key,
    this.width,
    this.height,
    this.borderRadius = const BorderRadius.all(Radius.circular(8)),
    this.baseColor,
    this.highlightColor,
  });

  /// Factory builder for rectangular shimmer (text lines, cards)
  factory CustomShimmer.rectangular({
    double? width,
    double? height,
    BorderRadiusGeometry borderRadius = const BorderRadius.all(
      Radius.circular(8),
    ),
    Color? baseColor,
    Color? highlightColor,
  }) {
    return CustomShimmer(
      width: width,
      height: height,
      borderRadius: borderRadius,
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  /// Factory builder for circular shimmer (icons, avatars)
  factory CustomShimmer.circular({
    double? size,
    Color? baseColor,
    Color? highlightColor,
  }) {
    return CustomShimmer(
      width: size,
      height: size,
      borderRadius: const BorderRadius.all(Radius.circular(999)),
      baseColor: baseColor,
      highlightColor: highlightColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Elegant and premium modern colors
    final defaultBase = isDark ? Colors.grey[850]! : Colors.grey[300]!;
    final defaultHighlight = isDark ? Colors.grey[700]! : Colors.grey[100]!;

    return Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            color: baseColor ?? defaultBase,
            borderRadius: borderRadius,
          ),
        )
        .animate(onPlay: (controller) => controller.repeat())
        .shimmer(
          duration: 1500.ms,
          color: highlightColor ?? defaultHighlight,
          angle: 45,
        );
  }
}
