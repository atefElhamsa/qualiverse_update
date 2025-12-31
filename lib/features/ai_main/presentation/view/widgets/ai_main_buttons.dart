import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

// Define a stateless widget for AI main buttons.
class AiMainButtons extends StatelessWidget {
  // Constructor for AiMainButtons.
  const AiMainButtons({super.key});

  @override
  Widget build(BuildContext context) {
    // Return a Row widget to display buttons horizontally.
    return Row(
      // Center the buttons horizontally.
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // SizedBox to control the size of the first button.
        SizedBox(
          // Set the height and width of the button using screen utilities.
          height: 68.h,
          width: 164.w,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                context.pushNamed(AppRoutes.aiReportScreen);
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
        // SizedBox to add space between the buttons.
        const SizedBox(width: 20),
        // SizedBox to control the size of the second button.
        SizedBox(
          // Set the height and width of the button using screen utilities.
          height: 68.h,
          width: 200.w,
          child: CustomButton(
            buttonModel: ButtonModel(
              onPressed: () {
                context.pushNamed(AppRoutes.aiDescriptionScreen);
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
      ],
    );
  }
}
