import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class SelectedSemesterWidget extends StatelessWidget {
  const SelectedSemesterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SemesterCubit, SemesterState>(
      builder: (context, state) {
        if (state is SemesterLoading) {
          return const CustomLoading();
        }
        if (state is SemesterError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              SemesterCubit.get(context).fetchSemesters();
            },
          );
        }
        if (state is SemesterSuccess) {
          final semesterCubit = SemesterCubit.get(context);
          final List<String> semesterNames = state.semesters
              .map((e) => e.name)
              .toList();
          final String? selectedSemesterName = state.selectedSemester?.name;
          return CustomDropButtonAndTitle(
            dropButtonModel: DropButtonModel(
              selectedData: selectedSemesterName,
              listOfData: semesterNames,
              hintText: "chooseSemester".tr(),
              hintSize: 20.sp,
              onChanged: (value) {
                if (value == null) return;
                final selectedModel = state.semesters.firstWhere(
                  (d) => d.name == value,
                );
                semesterCubit.selectSemester(semester: selectedModel);
              },
            ),
            title: "semester".tr(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
