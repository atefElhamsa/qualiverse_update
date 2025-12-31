import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

// A widget to display when a page is not found.
class NotFoundPage extends StatelessWidget {
  const NotFoundPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Center(
        child: Text(
          "notFoundPage".tr(),
          style: TextStyle(fontSize: 40.sp, color: AppColors.red),
        ),
      ),
    );
  }
}
