import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class DepartmentBar extends StatefulWidget {
  final DepartmentDataModel item;
  final double maxValue;
  final double maxHeight;
  final Duration delay;

  const DepartmentBar({
    super.key,
    required this.item,
    required this.maxValue,
    required this.maxHeight,
    required this.delay,
  });

  @override
  State<DepartmentBar> createState() => DepartmentBarState();
}

class DepartmentBarState extends State<DepartmentBar> {
  bool animated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(widget.delay, () {
        if (mounted) setState(() => animated = true);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = (widget.item.value / widget.maxValue) * widget.maxHeight;
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Value on top
          AnimatedOpacity(
            duration: const Duration(milliseconds: 400),
            opacity: animated ? 1 : 0,
            child: CustomText(
              title: widget.item.value.toInt().toString(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(fontSize: 13.sp),
            ),
          ),
          const SizedBox(height: 4),
          // Bar
          SizedBox(
            height: widget.maxHeight,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 700),
                curve: Curves.easeOutCubic,
                width: 115.w,
                height: animated ? barHeight : 0,
                decoration: BoxDecoration(
                  color: AppColors.evidenceColorSlide,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(3.r),
                    topRight: Radius.circular(3.r),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          // Label below
          CustomText(
            title: widget.item.label,
            textAlign: TextAlign.center,
            textStyle: GoogleFonts.inter(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color:
                  Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? AppColors.textGrey
                  : AppColors.white.withOpacity(0.75),
            ),
          ),
        ],
      ),
    );
  }
}
