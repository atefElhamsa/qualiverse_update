import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesButtonsReportDescriptionWidget extends StatelessWidget {
  const CoursesButtonsReportDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: SizedBox(
            height: 80.h,
            width: 180.w,
            child: CustomButton(
              buttonModel: ButtonModel(
                onPressed: () {
                  context.pushNamed(AppRoutes.rapporteurReportFirstTermScreen);
                },
                backgroundColor: AppColors.scaffoldLight1,
                radius: 20,
                customText: CustomText(
                  title: "report".tr(),
                  textStyle: Theme.of(context).textTheme.headlineMedium!,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Padding(
          padding: EdgeInsets.only(top: 40.h),
          child: SizedBox(
            height: 80.h,
            width: 218.w,
            child: CustomButton(
              buttonModel: ButtonModel(
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.courseSpecificationFirstTermScreen,
                  );
                },
                backgroundColor: AppColors.colorButtonLight,
                radius: 20,
                customText: CustomText(
                  title: "specification".tr(),
                  textStyle: Theme.of(context).textTheme.headlineMedium!,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
