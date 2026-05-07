import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class IndicatorsTable extends StatefulWidget {
  const IndicatorsTable({super.key});

  @override
  State<IndicatorsTable> createState() => _IndicatorsTableState();
}

class _IndicatorsTableState extends State<IndicatorsTable> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) fetchIfReady();
    });
  }

  void fetchIfReady() {
    if (!mounted) return;

    final yearId = AcademicYearCubit.get(context).selectedAcademicYear?.id;
    final typesCubit = TypesCubit.get(context);
    final typeState = typesCubit.state;

    int? departmentId;
    if (typeState is TypesSuccess && typeState.selectedIndex != -1) {
      final typeName = typeState.types[typeState.selectedIndex].name.toLowerCase();
      if (typeName.contains('institutional') || typeName.contains('مؤسسي')) {
        departmentId = null;
      } else {
        departmentId = DepartmentCubit.get(context).selectedDepartment?.id;
      }
    } else {
      departmentId = DepartmentCubit.get(context).selectedDepartment?.id;
    }

    final criterionId = ProgramAccreditationCubit.get(
      context,
    ).selectedProgramAccreditation?.id;

    if (yearId != null && criterionId != null) {
      CycleIndicatorCubit.get(context).fetchCycleIndicators(
        yearId: yearId,
        departmentId: departmentId,
        criterionId: criterionId,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProgramAccreditationCubit, ProgramAccreditationState>(
      listener: (context, state) => fetchIfReady(),
      child: BlocBuilder<CycleIndicatorCubit, CycleIndicatorState>(
        builder: (context, state) {
          if (state is CycleIndicatorLoading) {
            return const CustomLoading();
          }
          if (state is CycleIndicatorError) {
            return RetryWidget(title: state.error, onPressed: fetchIfReady);
          }
          if (state is CycleIndicatorLoaded) {
            final cycleIndicators = state.cycleIndicators;
            return cycleIndicators.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CustomText(
                        title: 'noIndicators'.tr(),
                        textStyle: Theme.of(context).textTheme.headlineLarge!,
                      ),
                    ),
                  )
                : Column(
                    children: [
                      const IndicatorsHeader(),
                      ...cycleIndicators.asMap().entries.map(
                        (entry) => IndicatorsRowWidget(
                          cycleIndicator: entry.value,
                          index: entry.key,
                          total: cycleIndicators.length,
                        ),
                      ),
                    ],
                  );
          }
          if (state is CycleIndicatorInitial) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 40.h),
                child: CustomText(
                  title: 'pleaseSelectTheCriterion'.tr(),
                  textStyle: Theme.of(context).textTheme.headlineLarge!
                      .copyWith(color: AppColors.grey, fontSize: 15.sp),
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}
