import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../routing/all_routes_imports.dart';

class CyclesListItems extends StatelessWidget {
  const CyclesListItems({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AcademicYearCubit, AcademicYearState>(
      builder: (context, state) {
        if (state is AcademicYearLoading) {
          return const CustomLoading();
        }
        if (state is AcademicYearError) {
          return Center(child: Text(state.message));
        }
        if (state is AcademicYearSuccess) {
          final academicYears = state.academicYears;
          return academicYears.isEmpty
              ? const Padding(
                  padding: EdgeInsets.all(24),
                  child: CustomText(
                    title: 'No data found',
                    textStyle: TextStyle(color: AppColors.grey),
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
