import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:qualiverse/routing/all_routes_imports.dart';

class ScheduleStep extends StatelessWidget {
  const ScheduleStep({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AiDescriptionCubit>();
    return StepWrapper(
      title: "scheduleInfo".tr(),
      icon: Icons.calendar_month_rounded,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 35.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.timer_outlined,
              size: 70.sp,
              color: const Color(0xFF0D47A1).withOpacity(0.2),
            ),
            SizedBox(height: 25.h),
            SizedBox(
              width: 400.w,
              child: PremiumInputField(
                label: "totalWeeklyHours".tr(),
                controller: cubit.totalHoursController,
                icon: Icons.watch_later_rounded,
                hint: "e.g. 40",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
