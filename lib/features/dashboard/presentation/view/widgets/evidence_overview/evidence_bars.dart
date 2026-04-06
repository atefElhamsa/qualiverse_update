import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceBars extends StatefulWidget {
  final List<CriterionDataModel> data;
  final double maxValue;

  const EvidenceBars({super.key, required this.data, required this.maxValue});

  @override
  State<EvidenceBars> createState() => _EvidenceBarsState();
}

class _EvidenceBarsState extends State<EvidenceBars>
    with TickerProviderStateMixin {
  late List<AnimationController> controllers;
  late List<Animation<double>> barAnimations;
  late List<Animation<double>> fadeAnimations;
  late List<Animation<Offset>> slideAnimations;

  @override
  void initState() {
    super.initState();
    initAnimations();
    startAnimations();
  }

  void initAnimations() {
    controllers = List.generate(
      widget.data.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 800),
      ),
    );

    barAnimations = controllers.map((c) {
      return CurvedAnimation(parent: c, curve: Curves.easeOutCubic);
    }).toList();

    fadeAnimations = controllers.map((c) {
      return Tween<double>(
        begin: 0,
        end: 1,
      ).animate(CurvedAnimation(parent: c, curve: const Interval(0.0, 0.5)));
    }).toList();

    slideAnimations = controllers.map((c) {
      return Tween<Offset>(
        begin: const Offset(-0.15, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: c, curve: Curves.easeOutCubic));
    }).toList();
  }

  void startAnimations() async {
    for (int i = 0; i < widget.data.length; i++) {
      await Future.delayed(Duration(milliseconds: 80 * i));
      if (!mounted) return;
      controllers[i].forward();
    }
  }

  @override
  void dispose() {
    for (final c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(widget.data.length, (i) {
        final d = widget.data[i];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: FadeTransition(
            opacity: fadeAnimations[i],
            child: SlideTransition(
              position: slideAnimations[i],
              child: Row(
                children: [
                  SizedBox(
                    width: 90,
                    child: CustomText(
                      title: d.label,
                      textAlign: TextAlign.right,
                      textStyle: GoogleFonts.inter(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w500,
                        color:
                            Theme.of(context).scaffoldBackgroundColor ==
                                AppColors.white
                            ? AppColors.textGrey
                            : AppColors.white.withOpacity(0.75),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return AnimatedBuilder(
                          animation: controllers[i],
                          builder: (context, _) {
                            final barWidth =
                                (d.value / widget.maxValue) *
                                constraints.maxWidth *
                                barAnimations[i].value;
                            return Stack(
                              children: [
                                Container(
                                  height: 28,
                                  width: constraints.maxWidth,
                                  decoration: BoxDecoration(
                                    color: AppColors.transparent,
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                                Container(
                                  width: barWidth,
                                  height: 28,
                                  decoration: BoxDecoration(
                                    color: AppColors.evidenceColorSlide,
                                    borderRadius: BorderRadius.circular(3.r),
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  AnimatedBuilder(
                    animation: barAnimations[i],
                    builder: (context, _) {
                      final displayValue = (d.value * barAnimations[i].value)
                          .toInt();
                      return CustomText(
                        title: displayValue.toString(),
                        textStyle: Theme.of(
                          context,
                        ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
