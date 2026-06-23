import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class BuildProvidersHeader extends StatelessWidget {
  final bool isAr;

  const BuildProvidersHeader({super.key, required this.isAr});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Align(
        alignment: isAr ? Alignment.centerRight : Alignment.centerLeft,
        child: Text(
          isAr ? "مزودو الخدمة المتاحون" : "Available AI Providers",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.colorButtonLight,
            fontSize: 18.sp,
          ),
        ),
      ),
    );
  }
}
