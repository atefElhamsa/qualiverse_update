import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class AnalysisButton extends StatelessWidget {
  const AnalysisButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          AppImages.analysis,
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
                context.pushNamed(AppRoutes.analysisFilesScreen);
              },
              backgroundColor:
                  Theme.of(context).scaffoldBackgroundColor == AppColors.white
                  ? AppColors.colorButtonLight
                  : AppColors.colorButtonDark,
              radius: 20,
              customText: CustomText(
                title: "analysis".tr(),
                textStyle: Theme.of(context).textTheme.headlineMedium!,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
