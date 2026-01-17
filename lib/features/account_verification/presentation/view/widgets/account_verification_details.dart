import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class AccountVerificationDetails extends StatelessWidget {
  const AccountVerificationDetails({super.key});

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
          child: Column(children: [AccountVerificationFieldAndBigImage()]),
        ),
      ),
    );
  }
}
