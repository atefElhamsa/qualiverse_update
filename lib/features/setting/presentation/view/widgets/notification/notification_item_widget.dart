import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../routing/all_routes_imports.dart';

class NotificationItemWidget extends StatelessWidget {
  const NotificationItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64.h,
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(25.r),
      ),
      child: Row(
        children: [
          Expanded(
            child: CustomText(
              title: "John Doe",
              textStyle: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.drColor,
              ),
            ),
          ),
          Expanded(
            child: CustomText(
              title: "12 July 2025",
              textStyle: GoogleFonts.inter(
                fontSize: 24.sp,
                fontWeight: FontWeight.w400,
                color: AppColors.drColor,
              ),
            ),
          ),
          ViewDeleteContainer(iconData: Icons.remove_red_eye),
          SizedBox(width: 10),
          ViewDeleteContainer(iconData: Icons.delete_rounded),
        ],
      ),
    );
  }
}
