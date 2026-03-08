import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class EvidenceLegend extends StatelessWidget {
  const EvidenceLegend({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EvidenceStatusCubit, EvidenceStatusState>(
      builder: (context, state) {
        final cubit = context.read<EvidenceStatusCubit>();
        final data = cubit.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CustomText(
              title: 'Status',
              textStyle: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w600,
                color: AppColors.textGrey,
              ),
            ),
            const SizedBox(height: 8),
            ...List.generate(data.length, (i) {
              final isActive = cubit.activeIndex == i;
              return GestureDetector(
                onTap: () => cubit.onLegendTapped(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: isActive
                        ? data[i].color.withOpacity(0.1)
                        : AppColors.transparent,
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: isActive ? data[i].color : AppColors.transparent,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: isActive ? 14 : 11,
                        height: isActive ? 14 : 11,
                        decoration: BoxDecoration(
                          color: data[i].color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 8),
                      CustomText(
                        title: data[i].label,
                        textStyle: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: isActive
                              ? FontWeight.w600
                              : FontWeight.w400,
                          color: isActive ? data[i].color : AppColors.textBlack,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
          ],
        );
      },
    );
  }
}
