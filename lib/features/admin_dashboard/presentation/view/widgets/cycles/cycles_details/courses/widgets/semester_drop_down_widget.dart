import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import '../../../../../../../../../routing/all_routes_imports.dart';

class SemesterDropDownWidget extends StatefulWidget {
  final double? height;
  final bool isExpanded;
  final ValueChanged<int>? onChanged;
  final int? selectedId;
  const SemesterDropDownWidget({
    super.key,
    this.height,
    this.isExpanded = true,
    this.onChanged,
    this.selectedId,
  });

  @override
  State<SemesterDropDownWidget> createState() => _SemesterDropDownWidgetState();
}

class _SemesterDropDownWidgetState extends State<SemesterDropDownWidget> {
  @override
  void initState() {
    super.initState();
    SemesterCubit.get(context).fetchSemesters();
  }

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
            onPressed: () => SemesterCubit.get(context).fetchSemesters(),
          );
        }
        if (state is SemesterSuccess) {
          final semesters = state.semesters;
          final isValid = semesters.any((e) => e.id == state.selectedSemester?.id);
          final selectedValue = widget.selectedId ?? (isValid ? state.selectedSemester?.id : null);
          final selectedItem = semesters.where((s) => s.id == selectedValue).firstOrNull;

          return CustomBaseDropDown<SemesterModel>(
            items: semesters,
            itemLabelBuilder: (s) => s.name,
            itemValueBuilder: (s) => s.id,
            value: selectedItem,
            hint: 'semester'.tr(),
            height: widget.height,
            isExpanded: widget.isExpanded,
            onChanged: (value) {
              if (value == null) return;
              if (widget.onChanged != null) {
                widget.onChanged!(value as int);
                return;
              }
              final selectedModel = semesters.firstWhere((s) => s.id == value);
              SemesterCubit.get(context).selectSemester(semester: selectedModel);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
