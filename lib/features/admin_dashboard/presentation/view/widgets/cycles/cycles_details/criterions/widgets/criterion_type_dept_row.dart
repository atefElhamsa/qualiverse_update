import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import 'package:qualiverse/features/admin_dashboard/presentation/view/widgets/cycles/cycles_details/criterions/widgets/create_criterion_dialog_widgets.dart' hide buildLabel;
import 'package:qualiverse/routing/all_routes_imports.dart';
import 'package:easy_localization/easy_localization.dart';

class CriterionTypeDeptRow extends StatelessWidget {
  final int? selectedTypeId, selectedDeptId;
  final Function(int?) onTypeChanged, onDeptChanged;

  const CriterionTypeDeptRow({
    super.key, required this.selectedTypeId, required this.selectedDeptId,
    required this.onTypeChanged, required this.onDeptChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabelWithAsterisk('accreditationType'.tr()),
              SizedBox(height: 8.h),
              BlocBuilder<TypesCubit, TypesState>(builder: (context, state) {
                final types = state is TypesSuccess ? state.types : <TypeModel>[];
                return CustomBaseDropDown<TypeModel>(
                  items: types, itemLabelBuilder: (t) => t.name, itemValueBuilder: (t) => t.id,
                  value: types.where((t) => t.id == selectedTypeId).firstOrNull,
                  hint: 'selectType'.tr(), height: 45.h, onChanged: (val) => onTypeChanged(val as int?),
                );
              }),
            ],
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildLabel('department'.tr()),
              SizedBox(height: 8.h),
              CoursesDepartmentDropDownWidget(height: 45.h, isExpanded: true, selectedId: selectedDeptId, useCubitSelection: false, onChanged: onDeptChanged),
            ],
          ),
        ),
      ],
    );
  }
}
