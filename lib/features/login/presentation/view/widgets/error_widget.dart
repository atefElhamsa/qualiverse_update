import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

OverlayEntry? _currentOverlayEntry;

void showSnackBar(BuildContext context, String title, Color color) {
  _currentOverlayEntry?.remove();
  _currentOverlayEntry = null;

  final overlayState = Overlay.of(context);
  late OverlayEntry overlayEntry;

  overlayEntry = OverlayEntry(
    builder: (context) {
      return Positioned(
        bottom: 40.h,
        left: 20.w,
        right: 20.w,
        child: TweenAnimationBuilder<double>(
          tween: Tween(begin: 0.0, end: 1.0),
          duration: const Duration(milliseconds: 400),
          curve: Curves.easeOutBack,
          builder: (context, value, child) {
            return Transform.translate(
              offset: Offset(0, 50 * (1 - value)),
              child: Transform.scale(
                scale: 0.9 + (0.1 * value),
                child: Opacity(
                  opacity: value.clamp(0.0, 1.0),
                  child: child,
                ),
              ),
            );
          },
          child: Material(
            color: Colors.transparent,
            child: Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: IntrinsicHeight(
                child: Row(
                  children: [
                    SizedBox(width: 16.w),
                    Container(
                      padding: EdgeInsets.all(10.r),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        color == AppColors.red
                            ? Icons.error_outline_rounded
                            : color == AppColors.green
                                ? Icons.check_circle_outline_rounded
                                : Icons.info_outline_rounded,
                        color: Colors.white,
                        size: 28.r,
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 20.h),
                        child: CustomText(
                          title: title,
                          textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                fontWeight: FontWeight.w600,
                                fontSize: 16.sp,
                                color: Colors.white,
                              ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (overlayEntry.mounted) {
                          overlayEntry.remove();
                          if (_currentOverlayEntry == overlayEntry) {
                            _currentOverlayEntry = null;
                          }
                        }
                      },
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Icon(
                          Icons.close_rounded,
                          color: Colors.white.withOpacity(0.8),
                          size: 20.r,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );

  _currentOverlayEntry = overlayEntry;
  overlayState.insert(overlayEntry);

  Future.delayed(const Duration(seconds: 3), () {
    if (overlayEntry.mounted) {
      overlayEntry.remove();
      if (_currentOverlayEntry == overlayEntry) {
        _currentOverlayEntry = null;
      }
    }
  });
}
