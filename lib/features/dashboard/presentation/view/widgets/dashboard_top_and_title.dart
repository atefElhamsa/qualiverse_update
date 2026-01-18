import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class DashboardTopAndTitle extends StatelessWidget {
  const DashboardTopAndTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 230.h,
      child: Stack(
        children: [
          const FirstTermTop(),
          Positioned(
            top: 140.h,
            left: 0,
            right: 0,
            child: Center(
              child: CustomText(
                title: "dashboard".tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.displayLarge!.copyWith(fontSize: 50.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
