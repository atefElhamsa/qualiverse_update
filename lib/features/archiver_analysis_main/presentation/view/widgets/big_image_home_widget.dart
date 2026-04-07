import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class BigImageHomeWidget extends StatelessWidget {
  const BigImageHomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(63.r),
        child: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: AppColors.mainBlack.withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Image.asset(
            AppImages.homeBodySecondPartImage,
            width: 400.w,
            height: 318.h,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
