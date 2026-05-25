import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class CyclesListItems extends StatelessWidget {
  const CyclesListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AcademicYearCubit, AcademicYearState>(
      listener: (context, state) {
        if (state is AcademicYearAddedError) {
          showSnackBar(context, state.message, AppColors.red);
        }
        if (state is AcademicYearDeleted) {
          showSnackBar(context, state.message, AppColors.green);
        }
        if (state is AcademicYearDeleteError) {
          showSnackBar(context, state.message, AppColors.red);
        }
      },
      builder: (context, state) {
        if (state is AcademicYearLoading) {
          return const CustomLoading();
        }
        if (state is AcademicYearError) {
          return Center(child: Text(state.message));
        }
        if (state is AcademicYearSuccess ||
            state is AcademicYearAdded ||
            state is AcademicYearAddedError) {
          final academicYears = AcademicYearCubit.get(context).academicYears;
          return academicYears.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(24),
                  child: CustomText(
                    title: 'noDataFound'.tr(),
                    textStyle: const TextStyle(color: AppColors.grey),
                  ),
                )
              : Column(
                  children: academicYears
                      .asMap()
                      .entries
                      .map(
                        (e) => CyclesItemWidget(
                          academicYear: e.value,
                          index: e.key,
                          total: academicYears.length,
                        ),
                      )
                      .toList(),
                );
        }
        return const SizedBox();
      },
    );
  }
}
