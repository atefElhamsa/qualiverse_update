import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/dashboard/data/models/department_data_model.dart';

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
  void didUpdateWidget(covariant DepartmentBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.item.value != widget.item.value) {
      setState(() => animated = false);
      Future.delayed(const Duration(milliseconds: 50), () {
        if (mounted) setState(() => animated = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final barHeight = (widget.item.value / widget.maxValue) * widget.maxHeight;
    final displayHeight = barHeight < 2 ? 2.0 : barHeight;
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
              textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ),
          const SizedBox(height: 8),
          // Bar with background track
          SizedBox(
            height: widget.maxHeight,
            width: 45.w,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Background Track
                Container(
                  width: 45.w,
                  height: widget.maxHeight,
                  decoration: BoxDecoration(
                    color: AppColors.textGrey.withOpacity(0.04),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                // Animated Fill Bar
                Align(
                  alignment: Alignment.bottomCenter,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 800),
                    curve: Curves.easeOutQuart,
                    width: 45.w,
                    height: animated ? displayHeight : 0,
                    decoration: BoxDecoration(
                      gradient: widget.item.value == 0
                          ? null
                          : LinearGradient(
                              begin: Alignment.bottomCenter,
                              end: Alignment.topCenter,
                              colors: [
                                AppColors.evidenceColorSlide.withOpacity(0.7),
                                AppColors.evidenceColorSlide,
                              ],
                            ),
                      color: widget.item.value == 0
                          ? AppColors.textGrey.withOpacity(0.1)
                          : null,
                      borderRadius: BorderRadius.circular(8.r),
                      boxShadow: widget.item.value > 0
                          ? [
                              BoxShadow(
                                color: AppColors.evidenceColorSlide.withOpacity(0.3),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              )
                            ]
                          : [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
