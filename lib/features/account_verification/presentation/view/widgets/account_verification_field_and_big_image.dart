import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class AccountVerificationFieldAndBigImage extends StatelessWidget {
  const AccountVerificationFieldAndBigImage({super.key});

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return Padding(
      padding: EdgeInsetsDirectional.only(top: 200.h, start: 45.w),
      child: Row(
        children: [
          AccountVerificationField(),
          const Spacer(),
          Padding(
            padding: EdgeInsets.only(
              right: isRTL ? 0.w : 15.w,
              left: isRTL ? 15.w : 0.w,
            ),
            child: Image.asset(
              AppImages.bigImageSignUp,
              width: 482.w,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }
}
