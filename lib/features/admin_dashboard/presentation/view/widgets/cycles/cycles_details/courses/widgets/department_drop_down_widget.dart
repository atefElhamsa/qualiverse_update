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
  final bool useCubitSelection;
  final bool? isDisabled;
  const CoursesDepartmentDropDownWidget({
    super.key,
    this.height,
    this.isExpanded = true,
    this.onChanged,
    this.selectedId,
    this.useCubitSelection = true,
    this.isDisabled,
  });

  @override
  State<CoursesDepartmentDropDownWidget> createState() => _CoursesDepartmentDropDownWidgetState();
}

class _CoursesDepartmentDropDownWidgetState extends State<CoursesDepartmentDropDownWidget> {
  @override
  void initState() {
    super.initState();
    final cubit = DepartmentCubit.get(context);
    if (cubit.departments.isEmpty) {
      cubit.fetchDepartments();
    }
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
          return BlocBuilder<LevelCubit, LevelState>(
            builder: (context, levelState) {
              bool isDisabled = widget.isDisabled ?? false;
              if (widget.isDisabled == null &&
                  levelState is LevelSuccess &&
                  levelState.selectedLevel != null) {
                if (levelState.selectedLevel!.levelNumber <= 2) {
                  isDisabled = true;
                }
              }

              final departments = state.departments;
              final isValid = departments.any(
                (e) => e.id == state.selectedDepartment?.id,
              );
              final selectedValue =
                  widget.selectedId ??
                  (widget.useCubitSelection && isValid
                      ? state.selectedDepartment?.id
                      : null);
              final selectedItem = departments
                  .where((d) => d.id == selectedValue)
                  .firstOrNull;

              return CustomBaseDropDown<DepartmentModel>(
                items: departments,
                itemLabelBuilder: (d) => d.name,
                itemValueBuilder: (d) => d.id,
                value: selectedItem,
                hint: 'selectTheDepartment'.tr(),
                height: widget.height,
                isExpanded: widget.isExpanded,
                isDisabled: isDisabled,
                onChanged: (value) {
                  if (value == null) return;
                  if (widget.onChanged != null) {
                    widget.onChanged!(value as int);
                    return;
                  }
                  final selectedModel = departments.firstWhere(
                    (d) => d.id == value,
                  );
                  DepartmentCubit.get(context).selectDepartment(
                    department: selectedModel,
                  );
                },
              );
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
