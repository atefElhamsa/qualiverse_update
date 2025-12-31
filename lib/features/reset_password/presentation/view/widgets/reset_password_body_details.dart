import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class ResetPasswordBodyDetails extends StatelessWidget {
  const ResetPasswordBodyDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        width: screenWidth / 1.28,
        height: screenHeight / 1.2,
        decoration: BoxDecoration(
          color: AppColors.white.withOpacity(0.75),
          borderRadius: BorderRadius.circular(22.r),
        ),
        child: const SingleChildScrollView(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(flex: 1, child: BigImageWidget()),
              Expanded(flex: 1, child: ResetRightPartWidget()),
            ],
          ),
        ),
      ),
    );
  }
}
