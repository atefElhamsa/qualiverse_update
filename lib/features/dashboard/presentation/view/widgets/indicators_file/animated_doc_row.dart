import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

const kFlex = [3, 3, 4, 2, 2, 1, 2, 2, 1];
const kHeaders = [
  'Indicator Name',
  'Criterion Name',
  'File Name',
  'Statues',
  'Uploaded By',
  'Year',
  'Quarter',
  'month',
  'Day',
];

Color statusColor(String s) {
  switch (s) {
    case 'Approved':
      return AppColors.approvedColorIndicator;
    case 'Pending':
      return AppColors.pendingColorIndicator;
    default:
      return AppColors.rejectedColorIndicator;
  }
}

class AnimatedDocRow extends StatefulWidget {
  final Doc doc;
  final int index;

  const AnimatedDocRow({super.key, required this.doc, required this.index});

  @override
  State<AnimatedDocRow> createState() => _AnimatedDocRowState();
}

class _AnimatedDocRowState extends State<AnimatedDocRow>
    with SingleTickerProviderStateMixin {
  late final AnimationController ctrl;
  late final Animation<double> fade;
  late final Animation<Offset> slide;

  @override
  void initState() {
    super.initState();
    ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );
    fade = CurvedAnimation(parent: ctrl, curve: Curves.easeOut);
    slide = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: ctrl, curve: Curves.easeOutCubic));

    Future.delayed(Duration(milliseconds: widget.index * 80), () {
      if (mounted) ctrl.forward();
    });
  }

  @override
  void dispose() {
    ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final d = widget.doc;
    final cells = [
      d.indicatorName,
      d.criterionName,
      d.fileName,
      d.status,
      d.uploadedBy,
      d.year.toString(),
      d.quarter,
      d.month,
      d.day.toString(),
    ];

    return FadeTransition(
      opacity: fade,
      child: SlideTransition(
        position: slide,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor == AppColors.white
                ? AppColors.grey
                : AppColors.mainBlack,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              children: List.generate(cells.length, (i) {
                final isStatus = i == 3;
                return Expanded(
                  flex: kFlex[i],
                  child: isStatus
                      ? Center(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: statusColor(d.status),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: CustomText(
                              title: d.status,
                              textAlign: TextAlign.center,
                              textStyle: GoogleFonts.inter(
                                color: AppColors.white,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      : Text(
                          cells[i],
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
