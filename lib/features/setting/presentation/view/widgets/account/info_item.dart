import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../core/all_core_imports/all_core_imports.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    super.key,
    required this.label,
    required this.value,
    required this.showChange,
    this.onPressed,
  });

  final String label;
  final String value;
  final bool showChange;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 230.w,
              child: CustomText(
                title: label.tr(),
                textStyle: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.greyLight),
              ),
            ),
            Expanded(
              child: Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w500,
                  color: AppColors.drColor,
                ),
              ),
            ),
            if (showChange)
              TextButton(
                onPressed: onPressed,
                child: Align(
                  alignment: Alignment.centerRight,
                  child: CustomText(
                    title: "change".tr(),
                    textStyle: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.drColor,
                    ),
                  ),
                ),
              ),
          ],
        ),
        SizedBox(height: 8.h),
        Divider(thickness: 1, color: AppColors.mainBlack),
        SizedBox(height: 8.h),
      ],
    );
  }
}

String maskPassword(String password) {
  return '*' * password.length;
}
