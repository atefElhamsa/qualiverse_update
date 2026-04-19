import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../routing/all_routes_imports.dart';

class CyclesDetailsTopWidget extends StatelessWidget {
  const CyclesDetailsTopWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 50.w, top: 100.h, end: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: AlignmentDirectional.centerEnd,
            child: CustomText(
              title: "adminPanel".tr(),
              textStyle: Theme.of(
                context,
              ).textTheme.bodySmall!.copyWith(fontSize: 24.sp),
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              MouseRegion(
                cursor: SystemMouseCursors.click,
                child: GestureDetector(
                  onTap: () {
                    context.read<AdminDashboardCubit>().backToCycles();
                  },
                  child: CustomText(
                    title: 'Cycle > ',
                    textStyle: Theme.of(context).textTheme.headlineLarge!
                        .copyWith(fontSize: 32.sp, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              CustomText(
                title: context
                    .read<AcademicYearCubit>()
                    .selectedAcademicYear!
                    .yearNumber
                    .toString(),
                textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  fontSize: 32.sp,
                  color: AppColors.mainBlack.withOpacity(0.65),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
