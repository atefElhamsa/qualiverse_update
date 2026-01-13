import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SideBarWidget extends StatelessWidget {
  const SideBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 360.w,
      decoration: BoxDecoration(
        color: AppColors.grey,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(23.r),
          bottomLeft: Radius.circular(23.r),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainBlack.withOpacity(0.25), // 25%
            offset: const Offset(5, 2), // X, Y
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SideBarDetails(),
    );
  }
}
