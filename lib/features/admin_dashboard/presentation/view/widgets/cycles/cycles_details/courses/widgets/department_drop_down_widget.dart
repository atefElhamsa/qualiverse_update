import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import 'package:qualiverse/routing/all_routes_imports.dart';

class CoursesDepartmentDropDownWidget extends StatefulWidget {
  final double? height;
  final bool isExpanded;
  final ValueChanged<int>? onChanged;
  final int? selectedId;
  const CoursesDepartmentDropDownWidget({
    super.key,
    this.height,
    this.isExpanded = true,
    this.onChanged,
    this.selectedId,
  });

  @override
  State<CoursesDepartmentDropDownWidget> createState() => _CoursesDepartmentDropDownWidgetState();
}

class _CoursesDepartmentDropDownWidgetState extends State<CoursesDepartmentDropDownWidget> {
  @override
  void initState() {
    super.initState();
    DepartmentCubit.get(context).fetchDepartments();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DepartmentCubit, DepartmentState>(
      builder: (context, state) {
        if (state is DepartmentLoading) {
          return CustomBaseDropDown<DepartmentModel>(
            items: const [],
            itemLabelBuilder: (d) => '',
            itemValueBuilder: (d) => 0,
            hint: 'Loading...',
            isLoading: true,
            height: widget.height,
            isExpanded: widget.isExpanded,
          );
        }
        if (state is DepartmentSuccess) {
          final departments = state.departments;
          final isValid = departments.any((e) => e.id == state.selectedDepartment?.id);
          final selectedValue = widget.selectedId ?? (isValid ? state.selectedDepartment?.id : null);
          final selectedItem = departments.where((d) => d.id == selectedValue).firstOrNull;

          return CustomBaseDropDown<DepartmentModel>(
            items: departments,
            itemLabelBuilder: (d) => d.name,
            itemValueBuilder: (d) => d.id,
            value: selectedItem,
            hint: 'selectTheDepartment'.tr(),
            height: widget.height,
            isExpanded: widget.isExpanded,
            onChanged: (value) {
              if (value == null) return;
              if (widget.onChanged != null) {
                widget.onChanged!(value as int);
                return;
              }
              final selectedModel = departments.firstWhere((d) => d.id == value);
              DepartmentCubit.get(context).selectDepartment(department: selectedModel);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
