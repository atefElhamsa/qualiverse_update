import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class EvidenceBars extends StatelessWidget {
  final List<CriterionDataModel> data;
  final double maxValue;

  const EvidenceBars({super.key, required this.data, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: data.map((d) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
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
                    color: AppColors.textGrey,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final barWidth =
                        (d.value / maxValue) * constraints.maxWidth;
                    return Stack(
                      children: [
                        Container(
                          height: 28,
                          decoration: BoxDecoration(
                            color: AppColors.transparent,
                            borderRadius: BorderRadius.circular(3.r),
                          ),
                        ),
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeOutCubic,
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
                ),
              ),
              const SizedBox(width: 8),
              CustomText(
                title: d.value.toInt().toString(),
                textStyle: Theme.of(
                  context,
                ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
