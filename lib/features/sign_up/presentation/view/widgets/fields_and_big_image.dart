import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/all_core_imports/all_core_imports.dart';
import 'package:qualiverse/features/all_features_imports/all_features_imports.dart';

class FieldsAndBigImage extends StatelessWidget {
  const FieldsAndBigImage({super.key});

  @override
  Widget build(BuildContext context) {
    final isRTL = Directionality.of(context) == TextDirection.rtl;
    return Row(
      children: [
        const SignUpFieldsAndButton(),
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
    );
  }
}
