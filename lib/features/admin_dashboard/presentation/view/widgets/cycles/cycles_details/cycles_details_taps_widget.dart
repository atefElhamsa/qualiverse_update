import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../routing/all_routes_imports.dart';

class CyclesDetailsTapsWidget extends StatelessWidget {
  const CyclesDetailsTapsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final _ = context.locale;
    return BlocBuilder<CycleTabsCubit, CycleTabsState>(
      builder: (context, state) {
        final cubit = context.read<CycleTabsCubit>();
        final tabs = CycleTab.values;
        return DefaultTabController(
          key: ValueKey(context.locale.languageCode),
          length: tabs.length,
          initialIndex: tabs.indexOf(cubit.currentTab),
          child: TabBar(
            onTap: (index) {
              final tab = tabs[index];
              cubit.changeTab(tab);
              DepartmentCubit.get(context).selectDepartment(department: null);
              LevelCubit.get(context).selectLevel(level: null);
              TermCubit.get(context).selectTerm(term: null);
            },
            isScrollable: true,
            tabAlignment: TabAlignment.start,
            dividerColor: Colors.transparent,
            indicatorColor: AppColors.blue,
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 3.h,
            labelColor: AppColors.blue,
            unselectedLabelColor: AppColors.mainGrey,
            padding: EdgeInsets.zero,
            labelPadding: EdgeInsetsDirectional.only(start: 30.w),
            labelStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            unselectedLabelStyle: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w400,
            ),
            tabs: tabs.map((tab) {
              final title = context.locale.languageCode == 'ar'
                  ? (tab == CycleTab.assignments
                        ? 'التكليفات'
                        : tab == CycleTab.indicators
                        ? 'المؤشرات'
                        : tab == CycleTab.criterions
                        ? 'المعايير'
                        : 'المقررات')
                  : tab.name.capitalizeFirst().tr();
              return Tab(text: title);
            }).toList(),
          ),
        );
      },
    );
  }
}
