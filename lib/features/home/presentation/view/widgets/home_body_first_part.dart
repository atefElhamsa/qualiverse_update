import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class HomeBodyFirstPart extends StatelessWidget {
  final double screenWidth;
  final double screenHeight;
  final bool isDrawerVisible;

  const HomeBodyFirstPart({
    super.key,
    required this.screenWidth,
    required this.screenHeight,
    required this.isDrawerVisible,
  });

  @override
  Widget build(BuildContext context) {
    final inherited = HomeBodyInherited.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        !isDrawerVisible
            ? CustomScaffoldHome(controller: inherited.controller)
            : const SizedBox(),
        const Spacer(),
        SizedBox(
          width: 200.w,
          height: 75.h,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                context.pushNamed(AppRoutes.accreditationScreen);
              },
              backgroundColor: AppColors.progressColor,
              radius: 32.5,
              customText: CustomText(
                title: "accreditation".tr(),
                textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 200.w,
          height: 75.h,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () async {
                context.pushNamed(AppRoutes.aiMainScreen);
              },
              backgroundColor: AppColors.aiModelColor,
              radius: 32.5,
              customText: CustomText(
                title: "aiModel".tr(),
                textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 24.sp,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
