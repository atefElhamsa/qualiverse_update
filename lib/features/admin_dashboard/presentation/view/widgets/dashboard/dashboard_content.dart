import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class DashboardContent extends StatelessWidget {
  const DashboardContent({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return BlocBuilder<AdminDashboardCubit, AdminDashboardState>(
      builder: (context, state) {
        final cubit = AdminDashboardCubit.get(context);
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Padding(
                padding: EdgeInsetsDirectional.only(end: 30.w),
                child: const Row(
                  children: [
                    Expanded(child: DashboardTabsRow()),
                    DashboardAcademicYearDropdown(),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              _buildContent(cubit.dashboardTabIndex),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return const DashboardOverview();
      default:
        return Container(
          height: 500.h,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.construction_rounded,
                size: 80.sp,
                color: AppColors.blue.withOpacity(0.5),
              ),
              SizedBox(height: 20.h),
              CustomText(
                title: "comingSoon".tr(),
                textStyle: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textGrey,
                ),
              ),
            ],
          ),
        );
    }
  }
}

class DashboardTabsRow extends StatelessWidget {
  const DashboardTabsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final titles = [
      'overview',
      // 'coursesHealth',
      // 'indicators',
      // 'files',
      // 'doctors',
      // 'activity',
    ];

    final cubit = AdminDashboardCubit.get(context);
    return Padding(
      padding: EdgeInsetsDirectional.only(start: 30.w),
      child: DefaultTabController(
        length: titles.length,
        initialIndex: cubit.dashboardTabIndex,
        child: TabBar(
          onTap: (index) => cubit.changeDashboardTab(index),
          isScrollable: true,
          tabAlignment: TabAlignment.start,
          dividerColor: Colors.transparent,
          indicatorColor: AppColors.blue,
          indicatorSize: TabBarIndicatorSize.label,
          indicatorWeight: 3.h,
          labelColor: AppColors.blue,
          unselectedLabelColor: AppColors.textGrey,
          padding: EdgeInsets.zero,
          labelPadding: EdgeInsetsDirectional.only(end: 30.w),
          labelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 13.sp,
          ),
          unselectedLabelStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            fontWeight: FontWeight.normal,
            fontSize: 13.sp,
          ),
          tabs: titles.map((title) => Tab(text: title.tr())).toList(),
        ),
      ),
    );
  }
}
