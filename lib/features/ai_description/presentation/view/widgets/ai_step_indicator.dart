import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiStepIndicator extends StatelessWidget {
  final int currentPage;
  final int totalSteps;

  const AiStepIndicator({
    super.key,
    required this.currentPage,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 100.w, vertical: 15.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(totalSteps, (index) {
          bool isActive = index <= currentPage;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 7.h,
              margin: EdgeInsets.symmetric(horizontal: 4.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.r),
                color: isActive
                    ? const Color(0xFF0D47A1)
                    : Colors.grey.shade200,
                boxShadow: index == currentPage
                    ? [
                        BoxShadow(
                          color: const Color(0xFF0D47A1).withOpacity(0.3),
                          blurRadius: 10,
                        ),
                      ]
                    : [],
              ),
            ),
          );
        }),
      ),
    );
  }
}
