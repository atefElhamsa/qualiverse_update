import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class StatusIndicator extends StatelessWidget {
  final bool isMatched;
  const StatusIndicator({super.key, required this.isMatched});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.r),
      decoration: BoxDecoration(
        color: (isMatched ? Colors.green : Colors.red).withOpacity(0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isMatched ? Icons.verified_rounded : Icons.cancel_rounded,
        color: isMatched ? Colors.green : Colors.red,
        size: 22.sp,
      ),
    );
  }
}
