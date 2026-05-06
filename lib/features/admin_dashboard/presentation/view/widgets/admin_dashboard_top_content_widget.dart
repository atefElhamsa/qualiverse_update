import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/admin_dashboard/admin_dashboard_cubit.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/controller/admin_dashboard/admin_dashboard_state.dart';

import '../../../../../core/all_core_imports/all_core_imports.dart';

class AdminDashboardTopContentWidget extends StatelessWidget {
  const AdminDashboardTopContentWidget({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CustomText(
                title: cubit.currentPageTitle.tr(),
                textStyle: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: AppColors.mainBlack,
                  fontWeight: FontWeight.w900,
                  fontSize: 30.sp,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(bottom: 10.h),
                child: CustomText(
                  title: 'adminPanel'.tr(),
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColors.textGrey.withOpacity(0.8),
                    fontWeight: FontWeight.w700,
                    fontSize: 20.sp,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
