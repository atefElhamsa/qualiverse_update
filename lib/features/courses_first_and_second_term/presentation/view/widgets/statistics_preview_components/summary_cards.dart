import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/courses_first_and_second_term/presentation/view/widgets/statistics_preview_components/stat_card.dart';

class SummaryCardsSection extends StatelessWidget {
  final int matchedCount;
  final int unmatchedCount;

  const SummaryCardsSection({
    super.key,
    required this.matchedCount,
    required this.unmatchedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            label: "matchedCount".tr(),
            value: matchedCount.toString(),
            color: const Color(0xFF10B981),
            icon: Icons.check_circle_rounded,
          ),
        ),
        SizedBox(width: 20.w),
        Expanded(
          child: StatCard(
            label: "unmatchedCount".tr(),
            value: unmatchedCount.toString(),
            color: const Color(0xFFEF4444),
            icon: Icons.report_gmailerrorred_rounded,
          ),
        ),
      ],
    );
  }
}
