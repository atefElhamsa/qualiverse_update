import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesMainButton extends StatelessWidget {
  const CoursesMainButton({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = context.locale;
    return Padding(
      padding: EdgeInsets.only(
        left: locale == const Locale('ar') ? 0 : 18.w,
        right: locale == const Locale('ar') ? 0 : 18.w,
        top: 60.h,
      ),
      child: SizedBox(
        width: 144.w,
        height: 48.h,
        child: CustomButton(
          buttonModel: ButtonModel(
            onPressed: () {
              final year = AcademicYearCubit.get(context).selectedAcademicYear;
              final department = DepartmentCubit.get(
                context,
              ).selectedDepartment;
              final level = LevelCubit.get(context).selectedLevel;
              if (year == null || department == null || level == null) {
                showSnackBar(
                  context,
                  "pleaseSelectedYearAndDepartment".tr(),
                  AppColors.red,
                );
              } else {
                context.pushNamed(AppRoutes.coursesFirstTermScreen);
              }
            },
            backgroundColor: AppColors.scaffoldLight1,
            radius: 32,
            customText: CustomText(
              title: "next".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.headlineLarge!.copyWith(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}
