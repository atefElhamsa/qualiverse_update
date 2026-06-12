import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class BasicInfoDepartment extends StatelessWidget {
  final MeModel meModel;
  const BasicInfoDepartment({super.key, required this.meModel});

  @override
  Widget build(BuildContext context) {
    final isLight =
        Theme.of(context).scaffoldBackgroundColor == AppColors.white;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(
          title: "basicInfo".tr(),
          textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: isLight
                ? Colors.white
                : AppColors.textFieldDark.withOpacity(0.2),
            borderRadius: BorderRadius.circular(16.r),
            border: Border.all(
              color: isLight
                  ? AppColors.grey.withOpacity(0.35)
                  : AppColors.textFieldDark,
              width: 1,
            ),
            boxShadow: isLight
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.02),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              InfoItem(
                label: "name".tr(),
                value: "${meModel.firstName} ${meModel.lastName}",
                showChange: false,
                icon: Icons.person_outline_rounded,
              ),
              Divider(
                height: 1,
                color: isLight
                    ? AppColors.grey.withOpacity(0.25)
                    : AppColors.textFieldDark.withOpacity(0.5),
              ),
              InfoItem(
                label: "email".tr(),
                value: meModel.email,
                showChange: false,
                icon: Icons.mail_outline_rounded,
              ),
              Divider(
                height: 1,
                color: isLight
                    ? AppColors.grey.withOpacity(0.25)
                    : AppColors.textFieldDark.withOpacity(0.5),
              ),
              InfoItem(
                label: "status".tr(),
                value: meModel.isActive ? "active".tr() : "deactive".tr(),
                showChange: false,
                icon: Icons.verified_user_outlined,
                trailing: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
                  decoration: BoxDecoration(
                    color: meModel.isActive
                        ? Colors.green.withOpacity(0.08)
                        : Colors.red.withOpacity(0.08),
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(
                      color: meModel.isActive
                          ? Colors.green.withOpacity(0.3)
                          : Colors.red.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 8.r,
                        height: 8.r,
                        decoration: BoxDecoration(
                          color: meModel.isActive ? Colors.green : Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        meModel.isActive ? "active".tr() : "deactive".tr(),
                        style: GoogleFonts.inter(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: meModel.isActive ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
