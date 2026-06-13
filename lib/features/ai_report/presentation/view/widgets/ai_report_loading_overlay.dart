import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AiReportLoadingOverlay extends StatelessWidget {
  final bool isAr;

  const AiReportLoadingOverlay({super.key, required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.55),
      child: Center(
        child: Container(
          width: 320.w,
          padding: EdgeInsets.symmetric(horizontal: 36.w, vertical: 36.h),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(
              color: Colors.white.withOpacity(0.25),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 40,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _AiSpinner(),
              SizedBox(height: 24.h),
              Text(
                isAr
                    ? 'جارٍ التحليل بالذكاء الاصطناعي'
                    : 'AI Analysis in Progress',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.sp,
                  letterSpacing: 0.3,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.h),
              Text(
                isAr
                    ? 'يرجى الانتظار، قد يستغرق ذلك دقيقة...'
                    : 'Please wait, this may take a minute...',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 13.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24.h),
              const _AiDots(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AiSpinner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 72.w,
      height: 72.w,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: 72.w,
            height: 72.w,
            child: CircularProgressIndicator(
              color: Colors.white.withOpacity(0.9),
              strokeWidth: 3,
            ),
          ),
          Container(
            width: 52.w,
            height: 52.w,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF42A5F5), Color(0xFF1565C0)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF1565C0).withOpacity(0.5),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.auto_awesome_rounded,
              color: Colors.white,
              size: 26.sp,
            ),
          ),
        ],
      ),
    );
  }
}

class _AiDots extends StatefulWidget {
  const _AiDots();

  @override
  State<_AiDots> createState() => _AiDotsState();
}

class _AiDotsState extends State<_AiDots> {
  int _activeIndex = 0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(milliseconds: 400), (_) {
      if (mounted) {
        setState(() => _activeIndex = (_activeIndex + 1) % 3);
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        final bool isActive = i == _activeIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive ? 10.w : 8.w,
          height: isActive ? 10.w : 8.w,
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white.withOpacity(isActive ? 1.0 : 0.3),
          ),
        );
      }),
    );
  }
}
