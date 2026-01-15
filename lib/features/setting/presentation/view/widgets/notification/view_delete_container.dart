import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class ViewDeleteContainer extends StatelessWidget {
  const ViewDeleteContainer({super.key, required this.iconData});
  final IconData iconData;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: 55.h,
        width: 55.w,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.drColor,
        ),
        child: Center(
          child: Icon(
            iconData,
            size: 28.sp,
            color: AppColors.viewAndDeleteIconColor,
          ),
        ),
      ),
    );
  }
}
