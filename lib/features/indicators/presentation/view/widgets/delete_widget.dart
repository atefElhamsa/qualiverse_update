import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class DeleteWidget extends StatelessWidget {
  const DeleteWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: Container(
          height: 35.h,
          width: 35.w,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.red,
          ),
          child: const Center(
            child: Icon(Icons.delete_outline_rounded, color: AppColors.black),
          ),
        ),
      ),
    );
  }
}
