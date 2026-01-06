import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routing/all_routes_imports.dart';

class SelectedDepartmentWidget extends StatelessWidget {
  const SelectedDepartmentWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentCubit, DepartmentState>(
      builder: (context, state) {
        if (state is DepartmentLoading) {
          return const CustomLoading();
        }
        if (state is DepartmentError) {
          return RetryWidget(
            title: state.message,
            onPressed: () {
              DepartmentCubit.get(context).fetchDepartments();
            },
          );
        }
        if (state is DepartmentSuccess) {
          final departmentCubit = DepartmentCubit.get(context);
          final List<String> departmentNames = state.departments
              .map((e) => e.localizedName(context))
              .toList();
          final String? selectedDepartmentName = state.selectedDepartment
              ?.localizedName(context);
          return CustomDropButtonAndTitle(
            dropButtonModel: DropButtonModel(
              selectedData: selectedDepartmentName,
              listOfData: departmentNames,
              hintText: "selectTheDepartment".tr(),
              hintSize: 20.sp,
              onChanged: (value) {
                if (value == null) return;
                final selectedModel = state.departments.firstWhere(
                  (d) => d.localizedName(context) == value,
                );
                departmentCubit.selectDepartment(department: selectedModel);
              },
            ),
            title: "department".tr(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
