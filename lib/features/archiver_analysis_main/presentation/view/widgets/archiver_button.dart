import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class ArchiverButton extends StatelessWidget {
  const ArchiverButton({super.key, required this.courseArgs});

  final CourseArgs courseArgs;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.archiver,
          height: 84.h,
          width: 84.w,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 30),
        SizedBox(
          height: 80.h,
          width: 198.w,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                context.pushNamed(
                  AppRoutes.coursesFirstAndSecondTermScreen,
                  extra: courseArgs,
                );
              },
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? AppColors.scaffoldLight1
                  : AppColors.colorButtonDark,
              radius: 20,
              customText: CustomText(
                title: "archiver".tr(),
                textStyle: Theme.of(context).textTheme.headlineMedium!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
