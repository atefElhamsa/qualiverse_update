import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/premium_input_field.dart';
import 'package:qualiverse/features/ai_description/presentation/view/widgets/step_wrapper.dart';
import 'package:qualiverse/features/ai_report/presentation/controller/ai_report_cubit.dart';

class AiReportCreditHoursStep extends StatelessWidget {
  const AiReportCreditHoursStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiReportCubit>();

    return StepWrapper(
      title: "creditHours".tr(),
      icon: Icons.hourglass_empty_rounded,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "creditHours".tr(),
                  controller: cubit.creditHoursController,
                  icon: Icons.access_time_rounded,
                  hint: "enterCreditHours".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "weeksCount".tr(),
                  controller: cubit.numWeeksController,
                  icon: Icons.calendar_today_rounded,
                  hint: "enterWeeksCount".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "theoreticalHours".tr(),
                  controller: cubit.theoreticalHoursController,
                  icon: Icons.menu_book_rounded,
                  hint: "enterTheoreticalHours".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "practicalHours".tr(),
                  controller: cubit.practicalHoursController,
                  icon: Icons.science_rounded,
                  hint: "enterPracticalHours".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "fieldHours".tr(),
                  controller: cubit.fieldHoursController,
                  icon: Icons.explore_rounded,
                  hint: "enterFieldHours".tr(),
                ),
              ),
              SizedBox(width: 20.w),
              Expanded(
                child: PremiumInputField(
                  label: "selfLearningHours".tr(),
                  controller: cubit.selfHoursController,
                  icon: Icons.psychology_rounded,
                  hint: "enterSelfLearningHours".tr(),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: PremiumInputField(
                  label: "otherHours".tr(),
                  controller: cubit.otherHoursController,
                  icon: Icons.more_horiz_rounded,
                  hint: "enterOtherHours".tr(),
                ),
              ),
              const Spacer(),
            ],
          ),
        ],
      ),
    );
  }
}
