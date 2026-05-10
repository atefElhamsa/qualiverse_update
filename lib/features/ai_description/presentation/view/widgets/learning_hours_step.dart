import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'step_wrapper.dart';
import 'weekly_learning_card.dart';

class LearningHoursStep extends StatelessWidget {
  const LearningHoursStep({super.key});

  @override
  Widget build(BuildContext context) {
    return StepWrapper(
      title: "learningHoursWeekly".tr(),
      icon: Icons.access_time_filled_rounded,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 25.w,
          mainAxisSpacing: 25.h,
          mainAxisExtent: 480.h,
        ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return WeeklyLearningCard(week: index + 1);
        },
      ),
    );
  }
}
