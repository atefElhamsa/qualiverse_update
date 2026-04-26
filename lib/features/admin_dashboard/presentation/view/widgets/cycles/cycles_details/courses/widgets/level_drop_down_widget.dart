import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:qualiverse/core/shared_widgets/custom_base_drop_down.dart';
import '../../../../../../../../../routing/all_routes_imports.dart';

class LevelDropDownWidget extends StatefulWidget {
  final double? height;
  final bool isExpanded;
  final ValueChanged<int>? onChanged;
  final int? selectedId;
  const LevelDropDownWidget({
    super.key,
    this.height,
    this.isExpanded = true,
    this.onChanged,
    this.selectedId,
  });

  @override
  State<LevelDropDownWidget> createState() => _LevelDropDownWidgetState();
}

class _LevelDropDownWidgetState extends State<LevelDropDownWidget> {
  @override
  void initState() {
    super.initState();
    LevelCubit.get(context).fetchLevels();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LevelCubit, LevelState>(
      builder: (context, state) {
        if (state is LevelLoading) {
          return const CustomLoading();
        }
        if (state is LevelError) {
          return RetryWidget(
            title: state.message,
            onPressed: () => LevelCubit.get(context).fetchLevels(),
          );
        }
        if (state is LevelSuccess) {
          final levels = state.levels;
          final isValid = levels.any((e) => e.id == state.selectedLevel?.id);
          final selectedValue = widget.selectedId ?? (isValid ? state.selectedLevel?.id : null);
          final selectedItem = levels.where((l) => l.id == selectedValue).firstOrNull;

          return CustomBaseDropDown<LevelModel>(
            items: levels,
            itemLabelBuilder: (l) => l.name,
            itemValueBuilder: (l) => l.id,
            value: selectedItem,
            hint: 'level'.tr(),
            height: widget.height,
            isExpanded: widget.isExpanded,
            onChanged: (value) {
              if (value == null) return;
              if (widget.onChanged != null) {
                widget.onChanged!(value as int);
                return;
              }
              final selectedModel = levels.firstWhere((l) => l.id == value);
              LevelCubit.get(context).selectLevel(level: selectedModel);
            },
          );
        }
        return const SizedBox();
      },
    );
  }
}
