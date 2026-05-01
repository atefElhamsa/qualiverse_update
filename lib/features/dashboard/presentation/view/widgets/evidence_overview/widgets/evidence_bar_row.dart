import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/dashboard/data/models/criterion_data_model.dart';

class EvidenceBarRow extends StatelessWidget {
  final CriterionDataModel data;
  final double maxValue;
  final Animation<double> barAnimation, fadeAnimation;
  final Animation<Offset> slideAnimation;
  final AnimationController controller;

  const EvidenceBarRow({
    super.key,
    required this.data,
    required this.maxValue,
    required this.barAnimation,
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Row(
            children: [
              _buildLabel(context),
              const SizedBox(width: 8),
              _buildBar(),
              const SizedBox(width: 8),
              _buildValue(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(BuildContext context) {
    final isWhite =
        Theme.of(context).scaffoldBackgroundColor == AppColors.white;
    return SizedBox(
      width: 90,
      child: CustomText(
        title: data.label,
        textAlign: TextAlign.right,
        textStyle: GoogleFonts.inter(
          fontSize: 10.sp,
          fontWeight: FontWeight.w500,
          color: isWhite
              ? AppColors.textGrey
              : AppColors.white.withOpacity(0.75),
        ),
      ),
    );
  }

  Widget _buildBar() {
    return Expanded(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return AnimatedBuilder(
            animation: controller,
            builder: (context, _) {
              final barWidth =
                  (data.value / maxValue) *
                  constraints.maxWidth *
                  barAnimation.value;
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
                    width: barWidth < 2 ? 2 : barWidth,
                    height: 28,
                    decoration: BoxDecoration(
                      color: data.value == 0
                          ? AppColors.textGrey.withOpacity(0.1)
                          : AppColors.evidenceColorSlide,
                      borderRadius: BorderRadius.circular(3.r),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildValue(BuildContext context) {
    return AnimatedBuilder(
      animation: barAnimation,
      builder: (context, _) {
        final displayValue = (data.value * barAnimation.value).toInt();
        return CustomText(
          title: displayValue.toString(),
          textStyle: Theme.of(
            context,
          ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
        );
      },
    );
  }
}
